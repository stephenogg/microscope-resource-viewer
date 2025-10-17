# =============================================================================
# App.R
# Microscope Resource Visualization (with linked filtering)
# Loads microscope_dat.RData (created by Data.R)
# =============================================================================

library(shiny)
library(tidyverse)
library(DT)
library(shinyWidgets)
library(bslib)



# Ensure consistent column names for UI usage
# system_df: owner, system_name, manufacturer, model, type, stand, geometry, location
# lens_df: owner, system_name, objective_class, manufacturer, catalog_number, magnification, numerical_aperture, working_distance, coverslip_thickness, thread, immersion, correction, special

ui <- fluidPage(
  theme = bs_theme(bootswatch = "flatly"),
  titlePanel("🔬 Microscope Resource Visualization"),
  
  tabsetPanel(
    id = "main_tab",
    type = "tabs",
    
    tabPanel("Systems",
             sidebarLayout(
               sidebarPanel(
                 width = 3,
                 h4("Filter Systems"),
                 pickerInput("owner_filter_sys", "Owner / Lab:",
                             choices = sort(unique(system_df$owner)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 pickerInput("type_filter_sys", "Microscope Type:",
                             choices = sort(unique(system_df$type)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 pickerInput("manufacturer_filter_sys", "Manufacturer:",
                             choices = sort(unique(system_df$manufacturer)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 pickerInput("geometry_filter_sys", "Geometry:",
                             choices = sort(unique(system_df$geometry)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 pickerInput("location_filter_sys", "Location:",
                             choices = sort(unique(system_df$location)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 
                 hr(),
                 h4("Customize Table"),
                 checkboxGroupInput("columns_sys", "Columns to Display:",
                                    choices = names(system_df), selected = names(system_df)),
                 br(),
                 actionButton("reset_sys", "Reset Filters", icon = icon("undo")),
                 br(), br(),
                 actionButton("info_sys", "ℹ️ Column Info")
               ),
               mainPanel(
                 width = 9,
                 h4("Microscope Systems"),
                 DTOutput("systems_table"),
                 br(),
                 tags$em("Tip: select one or more rows in this table (click) to filter Lenses & Detectors to those systems.")
               )
             )
    ),
    
    tabPanel("Lenses",
             sidebarLayout(
               sidebarPanel(
                 width = 3,
                 h4("Filter Lenses"),
                 pickerInput("owner_filter_len", "Owner / Lab:",
                             choices = sort(unique(lens_df$owner)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 pickerInput("system_filter_len", "System:",
                             choices = sort(unique(lens_df$system_name)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 pickerInput("imm_filter_len", "Immersion Medium:",
                             choices = sort(unique(lens_df$immersion)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 sliderInput("mag_filter_len", "Magnification Range:",
                             min = floor(min(lens_df$magnification, na.rm = TRUE)),
                             max = ceiling(max(lens_df$magnification, na.rm = TRUE)),
                             value = c(floor(min(lens_df$magnification, na.rm = TRUE)), ceiling(max(lens_df$magnification, na.rm = TRUE))),
                             step = 1),
                 
                 hr(),
                 h4("Customize Table"),
                 checkboxGroupInput("columns_len", "Columns to Display:",
                                    choices = names(lens_df), selected = names(lens_df)),
                 br(),
                 actionButton("reset_len", "Reset Filters", icon = icon("undo")),
                 br(), br(),
                 actionButton("info_len", "ℹ️ Column Info")
               ),
               mainPanel(
                 width = 9,
                 h4("Lenses"),
                 DTOutput("lenses_table"),
                 br(),
                 tags$em("Tip: Systems selection in the Systems tab will filter this table automatically.")
               )
             )
    ),
    
    tabPanel("Detectors",
             sidebarLayout(
               sidebarPanel(
                 width = 3,
                 h4("Filter Detectors"),
                 pickerInput("owner_filter_det", "Owner / Lab:",
                             choices = sort(unique(detector_df$owner)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 pickerInput("system_filter_det", "System:",
                             choices = sort(unique(detector_df$system_name)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 hr(),
                 h4("Customize Table"),
                 checkboxGroupInput("columns_det", "Columns to Display:",
                                    choices = names(detector_df), selected = names(detector_df)),
                 br(),
                 actionButton("reset_det", "Reset Filters", icon = icon("undo")),
                 br(), br(),
                 actionButton("info_det", "ℹ️ Column Info")
               ),
               mainPanel(
                 width = 9,
                 h4("Detectors"),
                 DTOutput("detectors_table"),
                 br(),
                 tags$em("Detector table is empty until detector_df is populated in Data.R.")
               )
             )
    )
  )
)

server <- function(input, output, session) {
  
  # Load the cleaned data
  load("microscope_data.RData") # system_df, lens_df, detector_df, column_help
  
  # --- Reactive filtered systems (used for DT display and selection)
  filtered_sys <- reactive({
    df <- system_df
    if (!is.null(input$owner_filter_sys) && length(input$owner_filter_sys) > 0) df <- df %>% filter(owner %in% input$owner_filter_sys)
    if (!is.null(input$type_filter_sys) && length(input$type_filter_sys) > 0) df <- df %>% filter(type %in% input$type_filter_sys)
    if (!is.null(input$manufacturer_filter_sys) && length(input$manufacturer_filter_sys) > 0) df <- df %>% filter(manufacturer %in% input$manufacturer_filter_sys)
    if (!is.null(input$geometry_filter_sys) && length(input$geometry_filter_sys) > 0) df <- df %>% filter(geometry %in% input$geometry_filter_sys)
    if (!is.null(input$location_filter_sys) && length(input$location_filter_sys) > 0) df <- df %>% filter(location %in% input$location_filter_sys)
    df
  })
  
  # --- Systems DT with selection enabled (multiple)
  output$systems_table <- renderDT({
    datatable(
      filtered_sys()[, input$columns_sys, drop = FALSE],
      selection = list(mode = "multiple", selected = NULL, target = "row"),
      extensions = "Buttons",
      options = list(pageLength = 10, scrollX = TRUE, dom = "Bfrtip", buttons = c("copy","csv","excel")),
      rownames = FALSE, class = "display compact nowrap"
    )
  }, server = FALSE)
  
  # When user selects rows in the systems table, derive selected system names and propagate to lens & detector system filters
  observeEvent(input$systems_table_rows_selected, {
    sel_rows <- input$systems_table_rows_selected
    if (length(sel_rows) > 0) {
      # We must use the same ordering as displayed in the table (filtered_sys())
      displayed <- filtered_sys()
      selected_systems <- displayed$system_name[sel_rows]
      # Update Lenses system picker to only those selected systems
      updatePickerInput(session, "system_filter_len", selected = selected_systems)
      # Update Detectors picker (if detectors table has that column)
      if ("system_name" %in% names(detector_df)) {
        updatePickerInput(session, "system_filter_det", selected = selected_systems[selected_systems %in% unique(detector_df$system_name)])
      }
    } else {
      # no selection -> clear lens & detector system filters (but do not change other lens filters)
      updatePickerInput(session, "system_filter_len", selected = character(0))
      updatePickerInput(session, "system_filter_det", selected = character(0))
    }
  })
  
  # Reset systems filters
  observeEvent(input$reset_sys, {
    updatePickerInput(session, "owner_filter_sys", selected = character(0))
    updatePickerInput(session, "type_filter_sys", selected = character(0))
    updatePickerInput(session, "manufacturer_filter_sys", selected = character(0))
    updatePickerInput(session, "geometry_filter_sys", selected = character(0))
    updatePickerInput(session, "location_filter_sys", selected = character(0))
    updateCheckboxGroupInput(session, "columns_sys", selected = names(system_df))
    # also clear any row selections in the systems table (client side)
    proxy_sys <- dataTableProxy("systems_table")
    selectRows(proxy_sys, NULL)
  })
  
  # Info modal for systems
  observeEvent(input$info_sys, {
    showModal(modalDialog(
      title = "System columns help",
      HTML(paste0("<ul>", paste0("<li><b>", names(column_help$system_df), "</b>: ", unlist(column_help$system_df), collapse = "</li><li>"), "</li></ul>")),
      easyClose = TRUE, footer = modalButton("Close")
    ))
  })
  
  
  # --- Lenses tab: linked filtering plus independent filters
  filtered_len <- reactive({
    df <- lens_df
    # If Systems rows have been selected, prefer that as a top-level filter
    sel_rows <- input$systems_table_rows_selected
    if (!is.null(sel_rows) && length(sel_rows) > 0) {
      displayed <- filtered_sys()
      selected_systems <- displayed$system_name[sel_rows]
      df <- df %>% filter(system_name %in% selected_systems)
    } else {
      # Otherwise consider the Lenses system picker
      if (!is.null(input$system_filter_len) && length(input$system_filter_len) > 0) {
        df <- df %>% filter(system_name %in% input$system_filter_len)
      }
    }
    
    if (!is.null(input$owner_filter_len) && length(input$owner_filter_len) > 0) df <- df %>% filter(owner %in% input$owner_filter_len)
    if (!is.null(input$imm_filter_len) && length(input$imm_filter_len) > 0) df <- df %>% filter(immersion %in% input$imm_filter_len)
    
    # Magnification slider filter (handle NA)
    if (!is.null(input$mag_filter_len)) {
      df <- df %>% filter(!is.na(magnification) & magnification >= input$mag_filter_len[1] & magnification <= input$mag_filter_len[2])
    }
    df
  })
  
  output$lenses_table <- renderDT({
    datatable(
      filtered_len()[, input$columns_len, drop = FALSE],
      extensions = "Buttons",
      options = list(pageLength = 10, scrollX = TRUE, dom = "Bfrtip", buttons = c("copy","csv","excel")),
      rownames = FALSE, class = "display compact nowrap"
    )
  }, server = FALSE)
  
  observeEvent(input$reset_len, {
    updatePickerInput(session, "owner_filter_len", selected = character(0))
    updatePickerInput(session, "system_filter_len", selected = character(0))
    updatePickerInput(session, "imm_filter_len", selected = character(0))
    updateSliderInput(session, "mag_filter_len",
                      value = c(floor(min(lens_df$magnification, na.rm = TRUE)), ceiling(max(lens_df$magnification, na.rm = TRUE))))
    updateCheckboxGroupInput(session, "columns_len", selected = names(lens_df))
  })
  
  observeEvent(input$info_len, {
    showModal(modalDialog(
      title = "Lens columns help",
      HTML(paste0("<ul>", paste0("<li><b>", names(column_help$lens_df), "</b>: ", unlist(column_help$lens_df), collapse = "</li><li>"), "</li></ul>")),
      easyClose = TRUE, footer = modalButton("Close")
    ))
  })
  
  
  # --- Detectors tab: linked filtering to systems selection
  filtered_det <- reactive({
    df <- detector_df
    sel_rows <- input$systems_table_rows_selected
    if (!is.null(sel_rows) && length(sel_rows) > 0) {
      displayed <- filtered_sys()
      selected_systems <- displayed$system_name[sel_rows]
      if ("system_name" %in% names(df)) {
        df <- df %>% filter(system_name %in% selected_systems)
      } else {
        # detector_df empty or has no system_name column; just return df
        df <- df
      }
    } else {
      if (!is.null(input$system_filter_det) && length(input$system_filter_det) > 0 && "system_name" %in% names(df)) {
        df <- df %>% filter(system_name %in% input$system_filter_det)
      }
    }
    
    if (!is.null(input$owner_filter_det) && length(input$owner_filter_det) > 0) df <- df %>% filter(owner %in% input$owner_filter_det)
    df
  })
  
  output$detectors_table <- renderDT({
    if (ncol(detector_df) == 0) {
      datatable(data.frame(Message = "No detector data available. Populate detector_df in Data.R."), options = list(dom = 't'))
    } else {
      datatable(
        filtered_det()[, input$columns_det, drop = FALSE],
        extensions = "Buttons",
        options = list(pageLength = 10, scrollX = TRUE, dom = "Bfrtip", buttons = c("copy","csv","excel")),
        rownames = FALSE, class = "display compact nowrap"
      )
    }
  }, server = FALSE)
  
  observeEvent(input$reset_det, {
    updatePickerInput(session, "owner_filter_det", selected = character(0))
    updatePickerInput(session, "system_filter_det", selected = character(0))
    updateCheckboxGroupInput(session, "columns_det", selected = names(detector_df))
  })
  
  observeEvent(input$info_det, {
    showModal(modalDialog(title = "Detectors help", "Detector table is a placeholder until detector_df is populated in Data.R.", easyClose = TRUE, footer = modalButton("Close")))
  })
}

shinyApp(ui, server)
