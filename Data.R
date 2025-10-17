# =============================================================================
# Data.R
# systems & lenses & Detectors
# Grouped by system using tribble() for readability
# Saves a single microscope_data.RData with system_df, lens_df, detector_df, column_help
# =============================================================================

library(tidyverse)

# ----------------------------
# Systems
# ----------------------------
system_df <- tribble(
  ~owner,      ~system_name,    ~manufacturer, ~model,       ~type,       ~stand,         ~geometry,  ~location,
  "center",    "880_Invert",     "Zeiss",       "LSM 880",    "confocal",  "Observer.Z1",  "inverted", "4.1",
  "center",    "800_Fish",       "Zeiss",       "LSM 800",    "confocal",  "Examiner.Z1",  "upright",  "4.1",
  "center",    "800_Histology",  "Zeiss",       "LSM 800",    "confocal",  "Imager.Z2",    "upright",  "4.1",
  "center",    "Ultramicroscope","Miltenyi",    "Blaze",      "lightsheet","",              "upright",  "4.3P",
  "center",    "880_Upright",    "Zeiss",       "LSM 880",    "confocal",  "Examiner.Z1",  "upright",  "4.9",
  "center",    "AxioScan.Z1",    "Zeiss",       "AxioScan.Z1","widefield", "",              "upright",  "4.3P",
  "Marín",     "Apotome",        "Zeiss",       "Apotome",    "widefield", "Imager.M2",    "upright",  "4.3D",
  "Marín",     "coppaFISH",      "Nikon",       "Ti2E",       "widefield", "Eclipse Ti2",  "invert",   "4.3D",
  "Marín",     "Scientifica",    "",             "",          "multiphoton","",              "invert", "4.33",
  "Berninger", "880_Invert",     "Zeiss",       "LSM 880",    "confocal",  "Observer",     "invert",   "4.11",
  "Berninger", "WF_Invert",      "Zeiss",       "Observer",   "widefield", "Observer",     "invert",   "4.11",
  "Ch'ng",     "WF_1",           "Nikon",       "Eclipse Ti", "widefield", "TiE",          "invert",   "4.7",
  "Ch'ng",     "WF_2",           "Nikon",       "Eclipse Ti", "widefield", "TiE",          "invert",   "4.7",
  "Long",      "Nikon_AX",       "Nikon",       "Eclipse Ti2","confocal",  "Ti2E",         "inverted", "4.33C",
  "Grubb",     "LSM_710",        "Zeiss",       "LSM 710",    "confocal",  "Examiner",     "upright",  "4.33",
  "Rico",      "Leica SP8",      "Leica",       "SP8",        "confocal",  "DMI 6000 B",   "invert",   "4.3D",
  "Rico",      "Stellaris",      "Leica",       "Stellaris",  "confocal",  "DMi 8",        "invert",   "4.3D"
)

# ----------------------------
# Lenses (grouped by system via comments)
# Columns: owner, system, class, manufacturer, catalog_number, magnification,
# numerical_aperture, working_distance, coverslip_thickness, thread, immersion,
# correction, special
# ----------------------------
lens_df <- tribble(
  ~owner, ~system_name, ~objective_class, ~manufacturer, ~catalog_number, ~magnification, ~numerical_aperture,
  ~working_distance, ~coverslip_thickness, ~thread, ~immersion, ~correction, ~special,
  
  # -- Lenses from the inverted 880 (center)
  "center","880_Invert","Plan-Apochromat","Zeiss","420782-9900-799",63,1.4,0.19,0.17,"M27X0.75","oil",NA,"DIC",
  "center","880_Invert","Plan-Apochromat","Zeiss","420762-9800-799",40,1.3,0.21,0.17,"M27X0.75","oil",NA,NA,
  "center","880_Invert","Plan-Apochromat","Zeiss","420650-9901-000",20,0.8,0.55,0.17,"M27X0.75","air",NA,NA,
  "center","880_Invert","EC Plan NEOFLUAR","Zeiss","420341-9911-000",10,0.3,5.2,NA,"M27X0.75","air",NA,"Ph1",
  
  # -- Lenses from the upright 880 (center)
  "center","880_Upright","C Plan-Apochromat","Zeiss","421782-9900-000",63,1.4,0.14,0.17,"M27X0.75","oil",NA,NA,
  "center","880_Upright","Plan-Apochromat","Zeiss","420650-9901-000",20,0.8,0.55,0.17,"M27X0.75","air",NA,NA,
  "center","880_Upright","Plan-Apochromat","Zeiss","421462-9900-799",40,1.0,2.5,0,"M27X0.75","water",NA,NA,
  "center","880_Upright","Plan-Apochromat","Zeiss","421452-960-000",20,1.0,2.4,0,"M27X0.75","water",NA,NA,
  "center","880_Upright","Plan-Apochromat","Zeiss","421452-9600-000",10,0.45,1.8,0.17,"M27X0.75","water",NA,NA,
  "center","880_Upright","Plan-Apochromat","Zeiss","420330-9901-000",5,0.16,18.5,0.17,"M27X0.75","air",NA,NA,
  
  # -- Lenses from the LSM800 (Fish) (center)
  "center","800_Fish","Plan-Apochromat","Zeiss","420782-9900-799",63,1.3,0.21,0.17,"M27X0.75","oil",NA,NA,
  "center","800_Fish","Plan-Apochromat","Zeiss","420650-9902-000",20,0.8,0.55,0.17,"M27X0.75","air",NA,NA,
  "center","800_Fish","Plan-Apochromat","Zeiss","420762-9800-000",40,1.3,0.21,0.17,"M27X0.75","oil",NA,NA,
  "center","800_Fish","Plan-Apochromat","Zeiss","421452-9601-000",20,1.0,0.55,0.17,"M27X0.75","water",NA,NA,
  
  # -- Lenses from the LSM800 (Histology) (center)
  "center","800_Histology","Plan-Apochromat","Zeiss","420782-9900-799",63,1.4,0.19,0.17,"M27X0.75","oil",NA,"DIC",
  "center","800_Histology","Plan-Apochromat","Zeiss","420762-9800-799",40,1.3,0.21,0.17,"M27X0.75","oil",NA,NA,
  "center","800_Histology","Plan-Apochromat","Zeiss","420650-9902-000",20,0.8,0.55,0.17,"M27X0.75","air",NA,NA,
  "center","800_Histology","EC Plan NEOFLUAR","Zeiss","420341-9911-000",10,0.3,5.2,NA,"M27X0.75","air",NA,"Ph1",
  "center","800_Histology","Plan-Apochromat","Zeiss","420630-9900-000",5,0.16,12.1,0.17,"M27X0.75","air",NA,NA,
  
  # -- Lenses from the AxioScan.Z1 (center)
  "center","AxioScan.Z1","Plan-Apochromat","Zeiss","420130-9900-000",5,0.25,12.5,0.17,"M27X0.75","air",NA,NA,
  "center","AxioScan.Z1","Plan-Apochromat","Zeiss","420640-9900-000",10,0.45,2.0,0.17,"M27X0.75","air",NA,NA,
  "center","AxioScan.Z1","Plan-Apochromat","Zeiss","420650-9902-000",20,0.8,0.55,0.17,"M27X0.75","air",NA,NA,
  "center","AxioScan.Z1","Plan-Apochromat","Zeiss","420660-9970-000",40,0.95,0.25,0.17,"M27X0.75","air",NA,NA,
  
  # -- Lenses from the Ultramicroscope (center)
  "center","Ultramicroscope","MI Plan","Miltenyi","150-000-493",1.1,0.1,17,NA,"","water","yes",NA,
  "center","Ultramicroscope","MI Plan","Miltenyi","150-001-654",4,0.35,16,NA,"","water","yes",NA,
  "center","Ultramicroscope","MI Plan","Miltenyi","150-000-495",12,0.53,10,NA,"","water","yes",NA,
  
  # -- Lenses from the cabinet (center)
  "center","cabinet","Plan-NEOFLUAR","Zeiss",NA,40,1.3,0.21,0.17,"M27X0.75","oil",NA,NA,
  "center","cabinet","Plan-NEOFLUAR","Zeiss",NA,20,0.5,2.0,0.17,"M27X0.75","air",NA,NA,
  "center","cabinet","Plan-NEOFLUAR","Zeiss",NA,10,0.3,5.2,0.17,"M27X0.75","air",NA,"Ph1",
  "center","cabinet","Plan-NEOFLUAR","Zeiss","440310-9903-000",2.5,0.075,9.8,0.17,"M27X0.75","air",NA,NA,
  
  # -- Lenses from the Marín Apotome
  "Marín","Apotome","EC Plan Neofluar","Zeiss","440310-9903-000",2.5,0.075,9.5,0.17,"M27X0.75","air",NA,NA,
  "Marín","Apotome","Plan Neofluar","Zeiss","420340-9901-000",10,0.3,5.2,NA,"M27X0.75","air",NA,NA,
  "Marín","Apotome","Plan-Apochromat","Zeiss","420650-9901-000",20,0.8,0.55,0.17,"M27X0.75","air",NA,NA,
  "Marín","Apotome","Plan-Apochromat","Zeiss","420762-9800-000",40,1.3,0.21,0.17,"M27X0.75","oil",NA,NA,
  "Marín","Apotome","Plan-Apochromat","Zeiss","420782-9900-000",63,1.4,0.19,0.17,"M27X0.75","oil",NA,"DIC",
  
  # -- Lenses from the Marín coppaFISH
  "Marín","coppaFISH","Plan-Apochromat","Nikon","MRD70470",40,0.95,0.25,0.17,"M25X0.75","air","yes",NA,
  "Marín","coppaFISH","Plan-Apochromat","Nikon","MRD70270",20,0.8,0.8,0.17,"M25X0.75","air",NA,NA,
  "Marín","coppaFISH","Plan Fluor","Nikon","MRH0015",10,0.3,16,0.17,"M25X0.75","air",NA,NA,
  
  # -- Lenses from the Rico Leica SP8
  "Rico","Leica SP8","Plan-Apochromat","Leica","506325",100,1.44,0.1,0.17,"M25X0.75","oil","yes",NA,
  "Rico","Leica SP8","Plan-Apochromat","Leica","506350",63,1.4,0.14,0.17,"M25X0.75","oil",NA,NA,
  "Rico","Leica SP8","Plan-Apochromat","Leica","506358",40,1.3,0.24,0.17,"M25X0.75","oil",NA,NA,
  "Rico","Leica SP8","PL Fluotar","Leica","506505",10,0.3,11,0.17,"M25X0.75","air",NA,NA,
  "Rico","Leica SP8","PL Fluotar","Leica","506503",20,0.5,1.15,0.17,"M25X0.75","air",NA,NA,
  
  # -- Lenses from the Rico Leica Stellaris
  "Rico","Stellaris","Plan-Apochromat","Leica","506424",10,0.4,2.56,0.17,"M25X0.75","air",NA,NA,
  "Rico","Stellaris","Plan-Apochromat","Leica","506517",20,0.75,0.62,0.17,"M25X0.75","air",NA,NA,
  "Rico","Stellaris","Plan-Apochromat","Leica","506428",40,1.3,0.17,0.17,"M25X0.75","oil",NA,NA,
  "Rico","Stellaris","Plan-Apochromat","Leica","506350",63,1.4,0.14,0.17,"M25X0.75","oil",NA,NA,
  
  # -- Lenses from the Berninger lab Inverted 880
  "Berninger","880_Invert","Plan-Apochromat","Zeiss","420782-9900-799",63,1.4,0.19,0.17,"M27X0.75","oil",NA,NA,
  "Berninger","880_Invert","LD Plan Neofluar","Zeiss","421360-9971-000",40,0.6,2.9,0.17,"M27X0.75","air","yes","LD",
  "Berninger","880_Invert","Plan-Apochromat","Zeiss","420650-9902-000",20,0.8,0.55,0.17,"M27X0.75","air",NA,NA,
  "Berninger","880_Invert","LD Plan Neofluar","Zeiss","421350-9971-000",20,0.4,7.9,0.17,"M27X0.75","oil","yes","LD",
  "Berninger","880_Invert","EC Plan Neofluar","Zeiss","420340-9901-000",10,0.3,5.2,0.17,"M27X0.75","air",NA,NA,
  
  # -- Lenses from the Berninger lab Inverted WF
  "Berninger","WF_Invert","EC Plan Neofluar","Zeiss","420341-9911-000",10,0.3,5.2,0.17,"M27X0.75","air",NA,"Ph1",
  "Berninger","WF_Invert","LD Plan Neofluar","Zeiss","421350-9971-000",20,0.4,7.9,0.17,"M27X0.75","air","yes","LD",
  "Berninger","WF_Invert","LD Plan Neofluar","Zeiss","421360-9970-000",40,0.6,2.9,0.17,"M27X0.75","air","yes","LD",
  
  # -- Lenses from the Ch'ng lab Inverted WF1
  "Ch'ng","WF_1","Plan","Nikon","MRL20102",10,0.25,10.5,0,"M25X0.75","air",NA,"Ph1",
  "Ch'ng","WF_1","Plan-Apochromat","Nikon","MRD70200",20,0.75,1,0.17,"M25X0.75","air",NA,NA,
  "Ch'ng","WF_1","Plan-Fluor","Nikon","MRH01401",40,1.3,0.24,0.17,"M25X0.75","oil",NA,NA,
  "Ch'ng","WF_1","Plan-Apochromat","Nikon","MRD01901",100,1.4,0.13,0.17,"M25X0.75","oil",NA,NA,
  
  # -- Lenses from the Ch'ng lab Inverted WF2
  "Ch'ng","WF_2","Plan","Nikon","MRL20102",10,0.25,10.5,0,"M25X0.75","air",NA,"Ph1",
  "Ch'ng","WF_2","Plan-Apochromat","Nikon","MRD70200",20,0.75,1,0.17,"M25X0.75","air",NA,NA,
  "Ch'ng","WF_2","Plan-Fluor","Nikon","MRH01401",40,1.3,0.24,0.17,"M25X0.75","oil",NA,NA,
  "Ch'ng","WF_2","Plan-Apochromat","Nikon","MRD01901",100,1.4,0.13,0.17,"M25X0.75","oil",NA,NA,
  
  # -- Lenses from the Grubb lab LSM710
  "Grubb","LSM_710","EC Plan Neofluar","Zeiss","440452-9903-000",40,1.3,0.2,0.17,"M27X0.75","oil",NA,NA,
  "Grubb","LSM_710","W N Achroplan","Zeiss","420947-9900-000",10,0.3,2.6,0,"M27X0.75","water",NA,NA,
  
  # -- Lenses from the Long lab Nikon_AX
  "Long","Nikon_AX","Plan Apo","Nikon","MRD70040",4,0.20,20,0,"M25X0.75","air",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRD70170",10,0.45,4,0.17,"M25X0.75","air",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRD70270",20,0.8,0.8,0.17,"M25X0.75","air",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRH01401",40,1.3,0.24,0.17,"M25X0.75","oil",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRD71670",60,1.42,0.15,0.17,"M25X0.75","oil",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRD73250",25,1.05,0.55,0.11,"M25X0.75","silicone oil","yes",NA
)

# Convert numeric-looking columns to numeric (they may already be)
lens_df <- lens_df %>%
  mutate(
    magnification = as.numeric(magnification),
    numerical_aperture = as.numeric(numerical_aperture),
    working_distance = as.numeric(working_distance),
    coverslip_thickness = as.numeric(coverslip_thickness)
  )


# ----------------------------
# Detectors 
# ----------------------------
detector_df <- tibble(
  owner = character(0),
  system_name = character(0),
  name = character(0),
  manufacturer = character(0),
  type = character(0),
  width = integer(0),
  height = integer(0),
  pixel_size = numeric(0),
  pixel_size_unit = character(0),
  sensor = character(0),
  full_well_capacity = numeric(0),
  digitization_rate = numeric(0),
  readout_speed = numeric(0),
  read_noise = numeric(0),
  dynamic_range = numeric(0),
  exp_time_min = numeric(0),
  exp_time_max = numeric(0),
  exp_time_unit = character(0),
  gain = numeric(0)
)

# ----------------------------
# Column help text (to populate info modals)
# ----------------------------
column_help <- list(
  system_df = list(
    owner = "Lab or facility that owns the microscope.",
    system_name = "Short unique name for the system (e.g., '880_Invert').",
    manufacturer = "Microscope manufacturer (Zeiss, Nikon, Leica, etc.).",
    model = "Product model (e.g., LSM 880).",
    type = "Microscope technique (confocal, widefield, multiphoton, lightsheet).",
    stand = "Microscope stand name or identifier (if provided).",
    geometry = "Orientation of the system: 'upright' or 'inverted'.",
    location = "Room number in NHH."
  ),
  lens_df = list(
    owner = "Owner/PI or unit for the lens.",
    system_name = "System the lens belongs to (matches system_df$system_name).",
    objective_class = "Manufacturer class/series for the objective.",
    manufacturer = "Objective manufacturer.",
    catalog_number = "Manufacturer catalog number (if provided).",
    magnification = "Objective magnification (x).",
    numerical_aperture = "Numerical aperture (NA) of the objective.",
    working_distance = "Free Working distance (micrometers).",
    coverslip_thickness = "Objective is corrected for a coverslip of this thickness (micrometers).",
    thread = "Mechanical thread or mount specification (if provided).",
    immersion = "Immersion medium (air, oil, water, silicone oil, etc.).",
    correction = "Indicates correction collar/adjustment or 'yes'/'no'.",
    special = "Special notes: DIC, Ph1, LD, etc."
  )
)

# ----------------------------
# Final small cleanups
# ----------------------------
# Standardize geometry values (original had "invert" and "inverted")
system_df <- system_df %>%
  mutate(geometry = tolower(geometry),
         geometry = ifelse(geometry == "invert", "inverted", geometry),
         stand = ifelse(is.na(stand) | stand == "", NA, stand),
         location = ifelse(is.na(location) | location == "", NA, location)
  )

# Make sure there are no capitals in the immersion and that the objective_class
# is of type character.
lens_df <- lens_df %>%
  mutate(
    immersion = tolower(as.character(immersion)),
    objective_class = as.character(objective_class)
  )

# ----------------------------
# Save consolidated data
# ----------------------------
save(system_df, lens_df, detector_df, column_help, file = "microscope_data.RData")
message("Saved microscope_data.RData with system_df, lens_df, detector_df, and column_help.")
