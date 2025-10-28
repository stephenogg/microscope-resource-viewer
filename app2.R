# =============================================================================
# App.R
# Microscope Resource Visualization (with linked filtering)
# =============================================================================

library(shiny)
library(tidyverse)
library(DT)
library(shinyWidgets)
library(bslib)
library(stringr)

# -------------------------------------------------------------------------
# Load Data
# -------------------------------------------------------------------------
load("microscope_data.RData") 
# Expected objects (from Data.R):
# system_df, lens_df, detector_PMT_df, detector_camera_df, detector_HyD_df, column_help


# ----------------------------
# Join logic for detectors
# ----------------------------

detector_PMT_df <- detector_df %>%
  filter(type %in% c("PMT", "HyD")) %>%
  inner_join(pmt_df, by = c("name", "owner_system"))

detector_camera_df <- detector_df %>%
  filter(type %in% c("CCD", "emCCD", "sCMOS")) %>%
  inner_join(camera_df, by = c("name", "owner_system"))

# -------------------------------------------------------------------------
# Merge Detectors into a Unified Data Frame
# -------------------------------------------------------------------------

detector_dfs <- list()

# Helper to add detector_type and owner_system safely
normalize_detector_df <- function(df, type_label) {
  if (!is.null(df) && nrow(df) > 0) {
    df <- df %>%
      mutate(detector_type = type_label) %>%
      # Create owner_system key if missing
      mutate(owner_system = ifelse("owner_system" %in% names(df),
                                   owner_system,
                                   paste(owner, system_name, sep = "_")))
    return(df)
  } else {
    return(NULL)
  }
}

detector_dfs <- list(
  normalize_detector_df(detector_PMT_df, "PMT"),
  normalize_detector_df(detector_camera_df, "Camera")
 # normalize_detector_df(detector_HyD_df, "HyD")
)

# Bind all detector types into one table
detector_df <- bind_rows(detector_dfs) %>% distinct()

# -------------------------------------------------------------------------
# Ensure Consistent Keys Across All Tables
# -------------------------------------------------------------------------
system_df <- system_df %>%
  mutate(owner_system = ifelse("owner_system" %in% names(system_df),
                               owner_system,
                               paste(owner, system_name, sep = "_")))

lens_df <- lens_df %>%
  mutate(owner_system = ifelse("owner_system" %in% names(lens_df),
                               owner_system,
                               paste(owner, system_name, sep = "_")))

if (!"owner_system" %in% names(detector_df) && nrow(detector_df) > 0) {
  detector_df <- detector_df %>%
    mutate(owner_system = paste(owner, system_name, sep = "_"))
}

# -------------------------------------------------------------------------
# UI
# -------------------------------------------------------------------------
ui <- fluidPage(
  theme = bs_theme(bootswatch = "flatly"),
  titlePanel("🔬 Microscope Resource Visualization"),
  
  tabsetPanel(
    id = "main_tab",
    type = "tabs",
    
    # ------------------ SYSTEMS TAB ------------------
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
                                    choices = names(system_df)[!names(system_df) == "owner_system"], 
                                    selected = names(system_df)[!names(system_df) == "owner_system"]),
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
                 tags$em("Tip: select one or more rows in this table to filter Lenses & Detectors.")
               )
             )
    ),
    
    # ------------------ LENSES TAB ------------------
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
                             value = c(floor(min(lens_df$magnification, na.rm = TRUE)), 
                                       ceiling(max(lens_df$magnification, na.rm = TRUE))),
                             step = 1),
                 sliderInput("na_filter_len", "Numerical Aperture Range:",
                             min = floor(min(lens_df$numerical_aperture, na.rm = TRUE)),
                             max = plyr::round_any(max(lens_df$numerical_aperture, na.rm = TRUE), 
                                                   accuracy = 0.1, f = ceiling),
                             value = c(floor(min(lens_df$numerical_aperture, na.rm = TRUE)), 
                                       ceiling(max(lens_df$numerical_aperture, na.rm = TRUE))),
                             step = 0.1),
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
                 tags$em("Tip: Systems selection filters this table automatically.")
               )
             )
    ),
    
    # ------------------ DETECTORS TAB ------------------
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
                 pickerInput("type_filter_det", "Detector Type:",
                             choices = sort(unique(detector_df$detector_type)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 pickerInput("manufacturer_filter_det", "Manufacturer:",
                             choices = sort(unique(detector_df$manufacturer)), multiple = TRUE,
                             options = list(`actions-box` = TRUE)),
                 hr(),
                 h4("Customize Table"),
                 checkboxGroupInput("columns_det", "Columns to Display:",
                                    choices = names(detector_df), 
                                    selected = c("owner", "system_name", "detector_type", "manufacturer", "model")),
                 br(),
                 actionButton("reset_det", "Reset Filters", icon = icon("undo")),
                 br(), br(),
                 actionButton("info_det", "ℹ️ Column Info")
               ),
               mainPanel(
                 width = 9,
                 h4("Detectors (Compact View)"),
                 DTOutput("detectors_table"),
                 br(),
                 tags$em("Click a detector row to view its full details.")
               )
             )
    )
  )
)

# -------------------------------------------------------------------------
# SERVER
# -------------------------------------------------------------------------
server <- function(input, output, session) {
  
  # ------------------ SYSTEMS TAB ------------------
  filtered_sys <- reactive({
    df <- system_df
    if (length(input$owner_filter_sys) > 0) df <- df %>% filter(owner %in% input$owner_filter_sys)
    if (length(input$type_filter_sys) > 0) df <- df %>% filter(type %in% input$type_filter_sys)
    if (length(input$manufacturer_filter_sys) > 0) df <- df %>% filter(manufacturer %in% input$manufacturer_filter_sys)
    if (length(input$geometry_filter_sys) > 0) df <- df %>% filter(geometry %in% input$geometry_filter_sys)
    if (length(input$location_filter_sys) > 0) df <- df %>% filter(location %in% input$location_filter_sys)
    df
  })
  
  output$systems_table <- renderDT({
    datatable(
      filtered_sys()[, input$columns_sys, drop = FALSE],
      selection = list(mode = "multiple", target = "row"),
      extensions = "Buttons",
      options = list(pageLength = 10, scrollX = TRUE, dom = "Bfrtip", buttons = c("copy", "csv", "excel")),
      rownames = FALSE, class = "display compact nowrap"
    )
  }, server = FALSE)
  
  observeEvent(input$systems_table_rows_selected, {
    sel_rows <- input$systems_table_rows_selected
    displayed <- filtered_sys()
    selected_systems <- displayed$owner_system[sel_rows]
    updatePickerInput(session, "system_filter_len", selected = selected_systems)
    updatePickerInput(session, "system_filter_det", selected = selected_systems)
  })
  
  # ------------------ LENSES TAB ------------------
  filtered_len <- reactive({
    df <- lens_df
    sel_rows <- input$systems_table_rows_selected
    if (length(sel_rows) > 0) {
      displayed <- filtered_sys()
      selected_systems <- displayed$owner_system[sel_rows]
      df <- df %>% filter(owner_system %in% selected_systems)
    } else if (length(input$system_filter_len) > 0) {
      df <- df %>% filter(owner_system %in% input$system_filter_len)
    }
    if (length(input$owner_filter_len) > 0) df <- df %>% filter(owner %in% input$owner_filter_len)
    if (length(input$imm_filter_len) > 0) df <- df %>% filter(immersion %in% input$imm_filter_len)
    if (!is.null(input$mag_filter_len)) df <- df %>% filter(magnification >= input$mag_filter_len[1] & magnification <= input$mag_filter_len[2])
    if (!is.null(input$na_filter_len)) df <- df %>% filter(numerical_aperture >= input$na_filter_len[1] & numerical_aperture <= input$na_filter_len[2])
    df
  })
  
  output$lenses_table <- renderDT({
    datatable(
      filtered_len()[, input$columns_len, drop = FALSE],
      extensions = "Buttons",
      options = list(pageLength = 10, scrollX = TRUE, dom = "Bfrtip", buttons = c("copy", "csv", "excel")),
      rownames = FALSE, class = "display compact nowrap"
    )
  }, server = FALSE)
  
  # ------------------ DETECTORS TAB ------------------
  filtered_det <- reactive({
    df <- detector_df
    sel_rows <- input$systems_table_rows_selected
    if (length(sel_rows) > 0) {
      displayed <- filtered_sys()
      selected_systems <- displayed$owner_system[sel_rows]
      df <- df %>% filter(owner_system %in% selected_systems)
    } else if (length(input$system_filter_det) > 0) {
      df <- df %>% filter(owner_system %in% input$system_filter_det)
    }
    if (length(input$owner_filter_det) > 0) df <- df %>% filter(owner %in% input$owner_filter_det)
    if (length(input$type_filter_det) > 0) df <- df %>% filter(detector_type %in% input$type_filter_det)
    if (length(input$manufacturer_filter_det) > 0) df <- df %>% filter(manufacturer %in% input$manufacturer_filter_det)
    df
  })
  
  output$detectors_table <- renderDT({
    datatable(
      filtered_det()[, input$columns_det, drop = FALSE],
      selection = "single",
      extensions = "Buttons",
      options = list(pageLength = 10, scrollX = TRUE, dom = "Bfrtip", buttons = c("copy", "csv", "excel")),
      rownames = FALSE, class = "display compact nowrap"
    )
  }, server = FALSE)
  
  # Click detector row → show full details in modal
  observeEvent(input$detectors_table_rows_selected, {
    sel_row <- input$detectors_table_rows_selected
    if (length(sel_row) == 1) {
      row_data <- filtered_det()[sel_row, , drop = FALSE]
      details_html <- paste0("<ul>", paste0("<li><b>", names(row_data), ":</b> ", as.character(row_data), collapse = "</li><li>"), "</li></ul>")
      showModal(modalDialog(
        title = paste("Detector Details -", row_data$system_name),
        HTML(details_html),
        easyClose = TRUE,
        footer = modalButton("Close")
      ))
    }
  })
}

# -------------------------------------------------------------------------
# Run App
# -------------------------------------------------------------------------
shinyApp(ui, server)
