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
  ~owner,      ~system_name,    ~manufacturer, ~model,       ~type,       ~stand,         ~geometry, ~serial_number,  ~location,
  "center",    "880_Invert",     "Zeiss",       "LSM 880",    "confocal",  "Observer.Z1",  "inverted", "2802100109",  "4.1",
  "center",    "800_Fish",       "Zeiss",       "LSM 800",    "confocal",  "Examiner.Z1",  "upright",  "2633000481",  "4.1",
  "center",    "800_Histology",  "Zeiss",       "LSM 800",    "confocal",  "Imager.Z2",    "upright",  "2633000464",  "4.1",
  "center",    "Ultramicroscope","Miltenyi",    "Blaze",      "lightsheet","",             "upright",  "",            "4.3P",
  "center",    "880_Upright",    "Zeiss",       "LSM 880",    "confocal",  "Examiner.Z1",  "upright",  "2850000158",  "4.9",
  "center",    "AxioScan.Z1",    "Zeiss",       "AxioScan.Z1","widefield", "",             "upright",  "4646000314",  "4.3P",
  "Marín",     "Apotome",        "Zeiss",       "Apotome",    "widefield", "Imager.M2",    "upright",  "3525001936",  "4.3D",
  "Marín",     "coppaFISH",      "Nikon",       "Ti2E",       "widefield", "Eclipse Ti2E", "invert",   "552005",      "4.3D",
  "Marín",     "Scientifica",    "",             "",          "multiphoton","",            "invert",     "",          "4.33",
  "Berninger", "880_Invert",     "Zeiss",       "LSM 880",    "confocal",  "Observer",     "invert",   "2850000269",  "4.11",
  "Berninger", "WF_Invert",      "Zeiss",       "Observer",   "widefield", "Observer 7",   "invert",   "3858002107",  "4.11",
  "Ch'ng",     "WF_1",           "Nikon",       "Eclipse TiE","widefield", "TiE",          "invert",   "536592",      "4.7",
  "Ch'ng",     "WF_2",           "Nikon",       "Eclipse TiE","widefield", "TiE",          "invert",   "531964",      "4.7",
  "Long",      "Nikon_AX",       "Nikon",       "Eclipse Ti2E","confocal", "Ti2E",         "inverted", "551770",      "4.33C",
  "Grubb",     "LSM_710",        "Zeiss",       "LSM 710",    "confocal",  "Examiner",     "upright",  "2502000475",  "4.33",
  "Rico",      "Leica SP8",      "Leica",       "SP8",        "confocal",  "DMI 6000 B",   "invert",   "8100000479",  "4.3D",
  "Rico",      "Stellaris",      "Leica",       "Stellaris",  "confocal",  "DMi 8",        "invert",   "8400000342",  "4.3D",
  "Long",      "Olympus_WF",     "Olympus",     "IX 70",      "widefield", "IX 70",        "invert",   "8K18177",     "4.33B",
  "Long",      "Nikon_AX_R",     "Nikon",       "Niokon AX R","confocal",  "Eclipse Ti2E", "invert",   "",            "4.33B"
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
  "center","880_Upright","Plan-Apochromat","Zeiss","421462-9900-799",40,1.0,2.5,NA,"M27X0.75","water",NA,NA,
  "center","880_Upright","Plan-Apochromat","Zeiss","421452-960-000",20,1.0,2.4,NA,"M27X0.75","water",NA,NA,
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
  "Ch'ng","WF_1","Plan","Nikon","MRL20102",10,0.25,10.5,NA,"M25X0.75","air",NA,"Ph1",
  "Ch'ng","WF_1","Plan-Apochromat","Nikon","MRD70200",20,0.75,1,0.17,"M25X0.75","air",NA,NA,
  "Ch'ng","WF_1","Plan-Fluor","Nikon","MRH01401",40,1.3,0.24,0.17,"M25X0.75","oil",NA,NA,
  "Ch'ng","WF_1","Plan-Apochromat","Nikon","MRD01901",100,1.4,0.13,0.17,"M25X0.75","oil",NA,NA,
  
  # -- Lenses from the Ch'ng lab Inverted WF2
  "Ch'ng","WF_2","Plan","Nikon","MRL20102",10,0.25,10.5,NA,"M25X0.75","air",NA,"Ph1",
  "Ch'ng","WF_2","Plan-Apochromat","Nikon","MRD70200",20,0.75,1,0.17,"M25X0.75","air",NA,NA,
  "Ch'ng","WF_2","Plan-Fluor","Nikon","MRH01401",40,1.3,0.24,0.17,"M25X0.75","oil",NA,NA,
  "Ch'ng","WF_2","Plan-Apochromat","Nikon","MRD01901",100,1.4,0.13,0.17,"M25X0.75","oil",NA,NA,
  
  # -- Lenses from the Grubb lab LSM710
  "Grubb","LSM_710","EC Plan Neofluar","Zeiss","440452-9903-000",40,1.3,0.2,0.17,"M27X0.75","oil",NA,NA,
  "Grubb","LSM_710","W N Achroplan","Zeiss","420947-9900-000",10,0.3,2.6,NA,"M27X0.75","water",NA,NA,
  "Grubb","LSM_710","plan Apochromat","Zeiss","420782-9900-799",63,1.4,0.19,0.17,"M27X0.75","water",NA,NA,
  "Grubb","LSM_710","Plan Apochromat","Zeiss","440762-1101-326",63,1.4,0.19,0.17,"M27X0.75","water",NA,"DIC",
  
  # -- Lenses from the Long lab Nikon_AX
  "Long","Nikon_AX","Plan Apo","Nikon","MRD70040",4,0.20,20,NA,"M25X0.75","air",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRD70170",10,0.45,4,0.17,"M25X0.75","air",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRD70270",20,0.8,0.8,0.17,"M25X0.75","air",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRH01401",40,1.3,0.24,0.17,"M25X0.75","oil",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRD71670",60,1.42,0.15,0.17,"M25X0.75","oil",NA,NA,
  "Long","Nikon_AX","Plan Apo","Nikon","MRD73250",25,1.05,0.55,0.17,"M25X0.75","silicone oil","yes",NA,
  
  # -- Lenses from the Long lab Nikon_AX_R
  "Long","Nikon_AX_R","Plan Apo","Nikon","MRD70040",4,0.20,20,NA,"M25X0.75","air",NA,NA,
  "Long","Nikon_AX_R","Plan Apo","Nikon","MRD70170",10,0.45,4,0.17,"M25X0.75","air",NA,NA,
  "Long","Nikon_AX_R","Plan Apo","Nikon","MRD70270",20,0.8,0.8,0.17,"M25X0.75","air",NA,NA,
  "Long","Nikon_AX_R","Plan Apo","Nikon","MRH01401",40,1.3,0.24,0.17,"M25X0.75","oil",NA,NA,
  "Long","Nikon_AX_R","Plan Apo","Nikon","MRD71670",60,1.42,0.15,0.17,"M25X0.75","oil",NA,NA,
  "Long","Nikon_AX_R","Plan Apo","Nikon","MRD73250",25,1.05,0.55,0.17,"M25X0.75","silicone oil","yes",NA,
  
  # -- Lenses from the Long lab Olympus WF
  "Long","Olympus_WF","UPlanFl N","Olympus","UPLFLN10X2",10,0.3,10,NA,"M26X0.75","air",NA,NA,
  "Long","Olympus_WF","LCPlanFl N","Olympus","LCPLFLN20X",20,0.4,12,NA,"M26X0.75","air",NA,"Ph 1, Compensation Cap P1.1",
  "Long","Olympus_WF","LCPlanFl N","Olympus","LCPFLN40X",40,0.6,10,NA,"M26X0.75","air",NA,"Ph2, Compensation Cap P1.1",
  "Long","Olympus_WF","Plan Apo","Olympus","PLAPO60XO",60,1.4,0.12,0.17,"M26X0.75","oil",NA,NA,
  "Long","Olympus_WF","UPlanFl N","Zeiss","EC Plan NeoFluar",5,0.15,13.6,0.17,"M25X0.75","air",NA,NA
)

# Convert numeric-looking columns to numeric (they may already be)
lens_df <- lens_df %>%
  mutate(
    owner_system = paste(owner,"_", system_name),
    magnification = as.numeric(magnification),
    numerical_aperture = as.numeric(numerical_aperture),
    working_distance = as.numeric(working_distance),
    coverslip_thickness = as.numeric(coverslip_thickness)
  )


# ----------------------------
# Detectors 
# ----------------------------

#-----------------
# Detector Types
#----------------
detector_types <- c("CCD", "emCCD","sCMOS", "PMT", "APD", "HyD")

detector_df <- tribble(
  ~owner, ~system_name, ~model, ~catalog_number, ~manufacturer, ~type,
  
  # Detectors from Queelim Ch'ng's microscopes
  "Ch'ng", "WF_1", "Orca-R2", "C10600-10B", "Hamamatsu", "CCD",
  "Ch'ng", "WF_2", "Orca-D2", "C11254-10B", "Hamamatsu", "CCD",
  
  # Detectors from the centre's microscopes
  "Center", "800_Fish", "Ch1", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "800_Fish", "Ch2", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "800_Fish", "Airyscan", NA, "Carl Zeiss GmbH", "PMT",
  
  "Center", "800_Histology", "Ch1", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "800_Histology", "Ch2", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "800_Histology", "Airyscan", NA, "Carl Zeiss GmbH", "PMT",
  
  "Center", "880_Invert", "Ch1", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "880_Invert", "ChS1", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "880_Invert", "Ch2", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "880_Invert", "Airyscan", NA, "Carl Zeiss GmbH", "PMT",
  
  "Center", "880_Upright", "Ch1", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "880_Upright", "ChS1", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "880_Upright", "Ch2", NA, "Carl Zeiss GmbH", "PMT",
  "Center", "880_Upright", "Airyscan", NA, "Carl Zeiss GmbH", "PMT",
  
  "Center", "AxioScan.Z1", "Axiocam 506m", NA, "Carl Zeiss GmbH", "CCD",
  "Center", "AxioScan.Z1", "Axiocam 105", NA, "Carl Zeiss GmbH", "CCD",
  "Center", "AxioScan.Z1", "Hitachi F203SCL", NA, "Hitachi", "CCD",
  
  "Center", "Ultramicroscope", "pco.EDGE", NA, "Photon Lines Optical Solutions", "sCMOS",

  
  "Marín", "Apotome", "Axiocam 503m", "426559-0000-000", "Carl Zeiss GmbH", "CCD",
  "Marín", "coppaFISH", "Orca-Fusion", "C14440-20UP", "Hamamatsu", "sCMOS",
  "Marín", "scientifica", "", NA, "", "",
  
  "Rico", "Leica SP8", "HyD1", NA, "Leica Microsystems", "HyD",
  "Rico", "Leica SP8", "HyD2", NA, "Leica Microsystems", "HyD",
  "Rico", "Leica SP8", "HyD3", NA, "Leica Microsystems", "HyD",
  "Rico", "Leica SP8", "HyD4", NA, "Leica Microsystems", "HyD",
  
  "Rico", "Stellaris", "HyDS1", NA, "Leica Microsystems", "HyD",
  "Rico", "Stellaris", "HyDS2", NA, "Leica Microsystems", "HyD",
  "Rico", "Stellaris", "HyDS3", NA, "Leica Microsystems", "HyD",
  "Rico", "Stellaris", "HyDX4", NA, "Leica Microsystems", "HyD",

  
  "Berninger", "880_Invert", "Ch1", NA, "Carl Zeiss GmbH", "PMT",
  "Berninger", "880_Invert", "ChS1", NA, "Carl Zeiss GmbH", "PMT",
  "Berninger", "880_Invert", "Ch2", NA, "Carl Zeiss GmbH", "PMT",
  "Berninger", "880_Invert", "Airyscan", NA, "Carl Zeiss GmbH", "PMT",
  
  "Berninger", "WF_Invert", "Axiocam 503m", NA, "Carl Zeiss GmbH", "CCD",
  
  "Long", "Olympus_WF", "CellCam 4612MT", NA, "Cairn GmBH", "CCD",
  
  "Long", "Nikon_AX", "", NA, "Nikon Corporation", "PMT",

  "Long", "Nikon_AX_R", "", NA, "Nikon Corporation", "PMT",
  
  "Grubb", "LSM_710", "", NA, "Nikon Corporation", "PMT"
)


detector_df$type <- factor(detector_df$type, levels = detector_types)

camera_df <- tribble(
  ~owner, ~system, ~name, ~array_width, ~array_height, ~pixel_width, ~pixel_height, ~pixel_size_unit, ~full_well_capacity,
  ~max_digitization_bit_depth, ~read_noise, ~readout_speed, ~fps, ~dynamic_range, ~exp_time_min, ~exp_time_max, ~exp_time_unit, 
  ~gain, ~electron_conversion_factor, ~quantum_efficiency, ~color, ~offset,
  
  "Ch'ng", "WF_1", "Orca-R2", 1024, 1344, 6.45, 6.45, "micrometers", 18000, 16, 6, 14, 8.5, 3000, 0.00001, 4200, "seconds", NA, NA, 0.7, FALSE, NA,
  "Ch'ng", "WF_1", "Orca-R2", 1024, 1344, 6.45, 6.45, "micrometers", 36000, 16, 6, 14, 8.5, 6000, 0.00001, 4200, "seconds", NA, NA, 0.7, FALSE, NA,
  "Ch'ng", "WF_1", "Orca-R2", 1024, 1344, 6.45, 6.45, "micrometers", 18000, 16, 6, 28, 16.2, 3000, 0.00001, 4200, "seconds", NA, NA, 0.7, FALSE, NA,
  
  "Ch'ng", "WF_2", "Orca-D2", 960, 1280, 6.45, 6.45, "micrometers", 18000, 12, 8, 20, 11.2, 2250, 0.000117, 60, "seconds", NA, NA, 0.7, FALSE, NA,
  
  "Marín", "Apotome", "Axiocam 503m", 1936, 1460, 4.54, 4.54, "micrometers", 15000, 14, 6, 13, 38, 2500, 0.000250, 60, "seconds", NA, NA, 0.76, FALSE, NA,
  "Marín", "Apotome", "Axiocam 503m", 1936, 1460, 4.54, 4.54, "micrometers", 15000, 14, 6.5, 39, 38, 2300, 0.000250, 60, "seconds", NA, NA, 0.76, FALSE, NA,
  
  "Marín", "coppaFISH", "Orca-Fusion", 2304, 2304, 6.5, 6.5, "micrometers", 15000, 16, 1.4, 473, 89.1, 10714, 0.000017, 10, "seconds", NA, NA, 0.82, FALSE, NA,
  "Marín", "coppaFISH", "Orca-Fusion", 2304, 2304, 6.5, 6.5, "micrometers", 15000, 16, 1.0, 123, 23.2, 15000, 0.000065, 10, "seconds", NA, NA, 0.82, FALSE, NA,
  "Marín", "coppaFISH", "Orca-Fusion", 2304, 2304, 6.5, 6.5, "micrometers", 15000, 16, 0.7, 28.8, 5.4, 21428, 0.000280, 10, "seconds", NA, NA, 0.82, FALSE, NA,
  
  "Berninger", "WF_Invert", "Axiocam 503m", 1936, 1460, 4.54, 4.54, "micrometers", 15000, 14, 6, 13, 38, 2500, 0.000250, 60, "seconds", NA, NA, 0.76, FALSE, NA,
  "Berninger", "WF_Invert", "Axiocam 503m", 1936, 1460, 4.54, 4.54, "micrometers", 15000, 14, 6.5, 39, 38, 2300, 0.000250, 60, "seconds", NA, NA, 0.76, FALSE, NA,
  
  "Center", "Axioscan.Z1", "Axiocam 506m", 2752, 2208, 4.54, 4.54, "micrometers", 15000, 14, 6, 13, 20, 2500, 0.000250, 60, "seconds", NA, NA, 0.76, FALSE, NA,
  "Center", "Axioscan.Z1", "Axiocam 105c", 2560, 1920, 2.2, 2.2, "micrometers", NA, 8, NA, NA, 15, NA, 0.000030, 1, "seconds", NA, NA, NA, TRUE, NA,
  "Center", "Axioscan.Z1", "Hitachi F203SCL", 1600, 1200, 4.4, 4.4, "micrometers", NA, 8, NA, 72, 30, 2500, 0.00001, 1, "seconds", NA, NA, 0.76, TRUE, NA,
  
  "Long", "Olympus_WF", "CellCam 4612MT", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA
  
  
)

pmt_df <- tribble(
  ~owner, ~system, ~name, ~coating, ~operating_speed, ~response_time, ~response_time_unit, ~dead_time, ~dead_time_response_unit, ~radiant_sensitivity, ~multi_anode, ~multi_anode_number, ~multi_anode_arrangement,
  
  "Center", "800_Fish", "Ch1", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Center", "800_Fish", "Ch2", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Center", "800_Fish", "Airyscan", "GaAsP", NA, NA, NA, NA, NA, NA, TRUE, 32, "round",
  
  "Center", "800_Histology", "Ch1", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Center", "800_Histology", "Ch2", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Center", "800_Histology", "Airyscan", "GaAsP", NA, NA, NA, NA, NA, NA, TRUE, 32, "round",
  
  "Center", "880_Invert", "Ch1", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Center", "880_Invert", "ChS1", "GaAsP", NA, NA, NA, NA, NA, NA, TRUE, 32, "linear",
  "Center", "880_Invert", "Ch2", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Center", "880_Invert", "Airyscan", "GaAsP", NA, NA, NA, NA, NA, NA, TRUE, 32, "round",
  
  "Center", "880_Upright", "Ch1", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Center", "880_Upright", "ChS1", "GaAsP", NA, NA, NA, NA, NA, NA, TRUE, 32, "linear",
  "Center", "880_Upright", "Ch2", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Center", "880_Upright", "Airyscan", "GaAsP", NA, NA, NA, NA, NA, NA, TRUE, 32, "round",
  
  "Berninger", "880_Invert", "Ch1", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Berninger", "880_Invert", "ChS1", "GaAsP", NA, NA, NA, NA, NA, NA, TRUE, 32, "linear",
  "Berninger", "880_Invert", "Ch2", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Berninger", "880_Invert", "Airyscan", "GaAsP", NA, NA, NA, NA, NA, NA, TRUE, 32, "round",
  
  "Rico", "Leica SP8", "HyD1", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Rico", "Leica SP8", "HyD2", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Rico", "Leica SP8", "HyD3", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Rico", "Leica SP8", "HyD4", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  
  "Rico", "Stellaris", "HyDS1", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Rico", "Stellaris", "HyDS2", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Rico", "Stellaris", "HyDX3", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  "Rico", "Stellaris", "HyDX4", "GaAsP", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  
  "Long", "Nikon_AX", "1", "unknown", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  
  "Long", "Nikon_AX_R", "1", "unknown", NA, NA, NA, NA, NA, NA, FALSE, NA, NA,
  
  "Grubb", "LSM_710", "Ch1", "unknown", NA, NA, NA, NA, NA, NA, FALSE, NA, NA
  
  
  
  
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
  ),
  detector_df = list(
    owner = "Owner/PI or unit for the detector",
    system_name = "System the detector belongs to (matches system_df$system_name).",
    model = "if known the model given by tne manufacturer.",
    manufacturer = "Detector manufacturer.",
    catalog_number = "Manufacturer catalog number (if provided).",
    type = "This detector is one of: 'CCD', 'emCCD', 'sCMOS','PMT','APD','Hybrid Detector'"
  ),
  camera_df = list(
    owner = "Owner/PI or unit for the detector",
    system_name = "System the detector belongs to (matches system_df$system_name).",
    name = "Name given by the manufacturer",
    array_width = "width of the effective sensor array in pixels.",
    array_height = "height of the effective sensor array in pixels.",
    pixel_width = "width of one pixel",
    pixel_height = "height of one pixel",
    pixel_size_unit = "untits of pixel size",
    full_well_capacity = "The maximum amount of charge (measured in electrons) a single pixel can hold before it becomes saturated",
    max_digitization_bit_depth = "resolution of the ADC, e.g. 8, 12, 16.",
    read_noise = "The noise introduced by the camera's electronics during the process of converting the charge collected by each pixel into a digital signal.",
    readout_speed = "Number of pixels per second that the camera can read off the chip (Million pixels per second.",
    fps = "Full frames per second that the camera can produce - sometimes limited by data transfer technology.",
    dynamic_range = "Derived variable, equal to the full_capacity/read_noise.",
    exp_time_min = "Minimum exposure time.",
    exp_time_max = "Maximum exposure time.",
    exp_time_unit = "units of the exposure time variables.",
    gain = "Does the camera provide on-board gain - provided as a factor.",
    electron_conversion_factor = "The conversion between the number of electrons ('e-') recorded by the camera and the number of digital units ('counts'') contained in the camera image.",
    quantum_efficiency = "expressed as a percentage, representing the probability that a photon of a wavelength at the max QE will be detected.",
    color = "TRUE,FALSE - Is this a color camera?",
    offset = "A small, constant signal added to each pixel to set the black level of an image, preventing pixel values from becoming zero and ensuring the entire histogram is shifted away from 0 (the left edge)."
  ),
  pmdt_df = list(
    owner = "Owner/PI or unit for the detector",
    system_name = "System the detector belongs to (matches system_df$system_name).",
    name = "Name that the manufacturer assigns to the PMT",
    coating = "Chemical coating used to increase the efficiency of the detector",
    operating_speed = "How many measurements per sencond does the device provide",
    response_time = "the total time it takes from when a photon hits the photocathode to when a measurable output signal is generated, including the time for the photocathode to emit a photoelectron and for the electrons to be multiplied through the dynode chain",
    response_time_unit = "units of response time",
    dead_time = "The period during which a photomultiplier tube cannot detect a new photon after having just detected one.",
    dead_time_unit = "units of dead time",
    radiant_sensitivity = "measure of the device's ability to convert incident light power into an electrical current, expressed in amperes  or milliamperes per watt. It is calculated by dividing the generated photocurrent at the photocathode by the incident radiant power at a specific wavelength.",
    multi_anode = "Does this detector incorporate more than one anode - TRUE/FALSE.",
    multi_anode_number = "How many anodes make up this detector.",
    multi_anode_arrangement = "The spatial arrangement of the anodes in teh detector."
  )
  
  
)

# ----------------------------
# Final small cleanups
# ----------------------------
# Standardize geometry values (original had "invert" and "inverted")
system_df <- system_df %>%
  mutate(geometry = tolower(geometry),
         geometry = ifelse(geometry == "invert", "inverted", geometry),
         owner_system = paste(owner,"_", system_name),
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
save(system_df, lens_df, detector_df, pmt_df, camera_df, column_help, file = "microscope_data.RData")
message("Saved microscope_data.RData with system_df, lens_df, detector_df, camera_df, pmt_df and column_help.")
