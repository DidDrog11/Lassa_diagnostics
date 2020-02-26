#### Load required packages ####
if (!require(shiny)) install.packages('shiny')
if (!require(shinythemes)) install.packages('shinythemes')
if (!require(DT)) install.packages('DT')
if (!require(rdrop2)) install.packages('rdrop2')
if (!require(shinyjs)) install.packages('shinyjs')
if (!require(shinyalert)) install.packages('shinyalert')


library(rdrop2)
library(shiny)
library(shinythemes)
library(shinyjs)
library(shinyalert)


source("saveData.R")
source("loadData.R")



#### Define UI ####
ui <-fluidPage(
  
  shinyjs::useShinyjs(),
  
  fluidPage(theme = shinytheme("cerulean")),
  
  # password area 
  fluidRow(column(
    10, align="center", offset = 0,
    div(id="login",style='width:100%; display:table',
        
        passwordInput("password", "Password:"),
        actionButton("go", "Go", class="btn-primary")   
    )
  )),

  shinyjs::hidden(fluidRow(id="form1",
    
    # Header for title
    hr(),
    titlePanel("Hollow fibre systematic review data input"),
    hr(),
    
    # insert small paragraph about the aim of the review 
    tags$div(
      tags$p("This form was created to streamline the data extraction for the systematic review"),
      tags$p("The aim of this systematic review is to explore the use of the in-vitro hollow fibre system for microbial cell culture."), 
      tags$p("The specific objectives of this systematic review are as follows:")
    ),
    tags$ul(
      tags$li("Describe the different hollow fibre systems/versions used "), 
      tags$li("Describe the uses of the hollow fibre systems"), 
      tags$li("Evaluate experimental parameters"),
      tags$li("Evaluate experiment outcomes"),
      tags$li("Recommend best practise")
    ),

    br(),
  
    # Questions to identify publication and reviewer 
    
    column(4, offset =0.5,
           selectInput('name', label = 'Reviewers name', 
                       choices = c(
                         "Select your name" =19,
                         "Zahra Sadouki" =1,
                         "Tim Mchugh" =2,
                         "Frank Kloprogge" =3,
                         "Emmanuel Wey"=4,
                         "Joe Standing"=5,
                         "John Readman"=6,
                         "Neil Stone"=7,
                         "Willaim Hope"=8,
                         "Christopher Darlow"=9,
                         "Jakko Van Ingen"=10,
                         "Rob Aarnoutse"=11,
                         "Mike Ruth"=12,
                         "Ludovic Pelligand"=13,
                         "Andrew Mead"=14,
                         "Davide Manissero"=15,
                         "Christopher Longshaw"=16,
                         "Julio Canseco"=17,
                         "Lynette Phee"= 18
                       ), 
                       selected = 0)),
    column(4, offset =0.5, 
           radioButtons('relevance', 
                        label = 'Is this publication relevant to the systematic review aims?',
                        choices = c("Yes" = 0, "No" = 1), 
                        selected = 0),
           conditionalPanel(condition = "input.relevance == 1",
                            textInput(inputId = "whynotrelevant",
                                      label   = "Please explain why this publication is not relevant",
                                      value = ""))
    ) # to close coulmn
  )), # to close fluid row
    
    shinyjs::hidden(fluidRow(id="form7",
    column(12, offset =0.5,
           selectInput('publicationid', label = "Select publication you will extract data from.", multiple = FALSE, width = "1000px",
                       choices = c(
                         "Please select relevant Pubmed ID" =85,
                         "31636062 Meropenem-Tobramycin Combination Regimens Combat Carbapenem-Resistant Pseudomonas aeruginosa in the Hollow-Fiber Infection Model Simulating Augmented Renal Clearance in Critically III Patients" =0,
                         "31611348 Pharmacodynamics of ClpP-activating antibiotic combinations against Gram-positive pathogens" =1,
                         "31109982 Pharmacodynamics of Tebipenem: New Options for Oral Treatment of Multidrug-Resistant Gram-Negative Infections." =2,
                         "30652018 Combining LC-MS/MS and hollow-fiber infection model for real-time quantitation of ampicillin to antimicrobial resistance." =3,
                         "30597040 Minocycline Immunomodulates via Sonic Hedgehog Signaling and Apoptosis and Has Direct Potency Against Drug-Resistant Tuberculosis." =4,
                         "30496466 Amikacin Dosing for MDR Tuberculosis: A Systematic Review to Establish or Revise the Current Recommended Dose for Tuberculosis Treatment." =5,
                         "30496459 Gatifloxacin Pharmacokinetics/Pharmacodynamics-based Optimal Dosing for Pulmonary and Meningeal Multidrug-resistant Tuberculosis." =6,
                         "30496457 Ethionamide Pharmacokinetics/Pharmacodynamics-derived Dose, the Role of MICs in Clinical Outcome, and the Resistance Arrow of Time in Multidrug-resistant Tuberculosis" =7,
                         "30397063 Pharmacokinetics/Pharmacodynamics of Vaborbactam, a Novel Beta-Lactamase Inhibitor, in Combination with Meropenem" =8,
                         "30385322 Dose optimization of moxifloxacin and linezolid against tuberculosis using mathematical modeling and simulation" =9,
                         "30249700 The Combination of Fosfomycin plus Meropenem Is Synergistic for Pseudomonas aeruginosa PAO1 in a Hollow-Fiber Infection Model." =10,
                         "30249693 Activity of Moxifloxacin against Mycobacterium tuberculosis in Acid Phase and Nonreplicative-Persister Phenotype Phase in a Hollow-Fiber Infection Model." =11,
                         "30104278 Meropenem Combined with Ciprofloxacin Combats Hypermutable Pseudomonas aeruginosa from Respiratory Infections of Cystic Fibrosis Patients." =12,
                         "29866874 Effect of Linezolid plus Bedaquiline against Mycobacterium tuberculosis in Log Phase, Acid Phase, and Nonreplicating-Persister Phase in an In Vitro Assay." =13,
                         "29866864 Linezolid kills acid-phase and nonreplicative-persister-phase mycobacterium tuberculosis in a hollow-fiber infection model" =14,
                         "29844047 Clofazimine for the treatment of mycobacterium kansasii" =15,
                         "29700814 Forecasting Clinical Dose-Response From Preclinical Studies in Tuberculosis Research: Translational Predictions With Rifampicin" =16,
                         "29636741 Differential Activity of the Combination of Vancomycin and Amikacin on Planktonic vs. Biofilm-Growing Staphylococcus aureus Bacteria in a Hollow Fiber Infection Model" =17,
                         "29632010 Polymyxin b in combination with enrofloxacin exerts synergistic killing against extensively drug-resistant pseudomonas aeruginosa" =18,
                         "29581114 Determination of the Dynamically Linked Indices of Fosfomycin for Pseudomonas aeruginosa in the Hollow Fiber Infection Model" =19,
                         "29530842 Evaluation of ceftolozane-tazobactam in combination with meropenem against pseudomonas aeruginosa sequence type 175 in a hollow-fiber infection model" =20,
                         "29507068 Exploring the Pharmacokinetic/Pharmacodynamic Relationship of Relebactam (MK-7655) in Combination with Imipenem in a Hollow-Fiber Infection Model" =21,
                         "29486233 Polymyxin B and fosfomycin thwart KPC-producing Klebsiella pneumoniae in the hollow-fibre infection model" =22,
                         "29463528 Optimization and Evaluation of Piperacillin-Tobramycin Combination Dosage Regimens against Pseudomonas aeruginosa for Patients with Altered Pharmacokinetics via the Hollow-Fiber Infection Model and Mechanism-Based Modeling." =23,
                         "29461629 Development and validation of a LC-MS/MS method for quantitation of fosfomycin - Application to in vitro antimicrobial resistance study using hollow-fiber infection model" =24,
                         "29439978 Pharmacokinetics of 2,000 Milligram Ertapenem in Tuberculosis Patients." =25,
                         "29437610 Optimization of a Meropenem-Tobramycin Combination Dosage Regimen against Hypermutable and Nonhypermutable Pseudomonas aeruginosa via Mechanism-Based Modeling and the Hollow-Fiber Infection Model." =26,
                         "29339388 Combating Carbapenem-Resistant Acinetobacter baumannii by an Optimized Imipenem-plus-Tobramycin Dosage Regimen: Prospective Validation via Hollow-Fiber Infection and Mathematical Modeling." =27,
                         "29311092 Repurposing and Reformulation of the Antiparasitic Agent Flubendazole for Treatment of Cryptococcal Meningoencephalitis, a Neglected Fungal Disease" =28,
                         "29180527 Azithromycin pharmacodynamics against persistent haemophilus influenzae in chronic obstructive pulmonary disease" =29,
                         "29091195 Ceftaroline efficacy against high-MIC clinical Staphylococcus aureus isolates in an in vitro hollow-fibre infection model" =30,
                         "28962026 Pharmacodynamics of teicoplanin against MRSA" =31,
                         "28922811 A programme to create short-course chemotherapy for pulmonary Mycobacterium avium disease based on pharmacokinetics/pharmacodynamics and mathematical forecasting" =32,
                         "28922810 A 'shock and awe' thioridazine and moxifloxacin combination-based regimen for pulmonary Mycobacterium avium-intracellulare complex disease." =33,
                         "28922809 A novel ceftazidime/avibactam, rifabutin, tedizolid and moxifloxacin (CARTM) regimen for pulmonary Mycobacterium avium disease" =34,
                         "28922808 The discovery of ceftazidime/avibactam as an anti-Mycobacterium avium agent" =35,
                         "28922807 Tedizolid is highly bactericidal in the treatment of pulmonary Mycobacterium avium complex disease" =36,
                         "28922806 Linezolid as treatment for pulmonary Mycobacterium avium disease" =37,
                         "28875168 Ceftazidime-avibactam has potent sterilizing activity against highly drug-resistant tuberculosis." =38,
                         "28743810 Polymyxin combinations combat Escherichia coli harboring mcr-1 and blaNDM-5: Preparation for a postantibiotic Era" =39,
                         "28584143 Linezolid dose that maximizes sterilizing effect while minimizing toxicity and resistance emergence for tuberculosis" =40,
                         "28505268 Pharmacodynamics of dose-escalated 'front-loading' polymyxin B regimens against polymyxin-resistant mcr-1-harbouring Escherichia coli." =41,
                         "28444224 Pharmacodynamics of colistin and fosfomycin: A 'treasure trove' combination combats KPC-producing Klebsiella pneumoniae" =42,
                         "28333347 Polymyxin-resistant, carbapenem-resistant Acinetobacter baumannii is eradicated by a triple combination of agents that lack individual activity" =43,
                         "28264846 Substantial Impact of Altered Pharmacokinetics in Critically Ill Patients on the Antibacterial Effects of Meropenem Evaluated via the Dynamic Hollow-Fiber Infection Model." =44,
                         "28167549 New Polymyxin B Dosing Strategies To Fortify Old Allies in the War against KPC-2-Producing Klebsiella pneumoniae." =45,
                         "28158470 Determining beta-lactam exposure threshold to suppress resistance development in Gram-negative bacteria" =46,
                         "28145085 Prediction of in vivo and in vitro infection model results using a semimechanistic model of avibactam and aztreonam combination against multidrug resistant organisms" =47,
                         "28052852 High-Dose Ampicillin-Sulbactam Combinations Combat Polymyxin-Resistant Acinetobacter baumannii in a Hollow-Fiber Infection Model." =48,
                         "27931793 In vitro pharmacodynamic evaluation of ceftolozane/tazobactam against beta-lactamase-producing Escherichia coli in a hollow-fibre infection model" =49,
                         "27821440 Bacterial Replication Rate Modulation in Combination with Antimicrobial Therapy: Turning the Microbe against Itself" =50,
                         "27795380 Pharmacodynamics of Aerosolized Fosfomycin and Amikacin against Resistant Clinical Isolates of Pseudomonas aeruginosa and Klebsiella pneumoniae in a Hollow-Fiber Infection Model: Experimental Basis for Combination Therapy." =51,
                         "27795375 Evaluating polymyxin B-based combinations against carbapenemresistant Escherichia coli in time-kill studies and in a hollow-fiber infection model" =52,
                         "27742640 A Faropenem, Linezolid, and Moxifloxacin Regimen for Both Drug-Susceptible and Multidrug-Resistant Tuberculosis in Children: FLAME Path on the Milky Way" =53,
                         "27742639 Concentration-Dependent Synergy and Antagonism of Linezolid and Moxifloxacin in the Treatment of Childhood Tuberculosis: The Dynamic Duo" =54,
                         "27742638 Linezolid for Infants and Toddlers With Disseminated Tuberculosis: First Steps" =55,
                         "27612961 From lead optimization to NDA approval for a new antimicrobial: Use of pre-clinical effect models and pharmacokinetic/pharmacodynamic mathematical modeling" =56,
                         "27494922 Polymyxin B in combination with doripenem against heteroresistant Acinetobacter baumannii: Pharmacodynamics of new dosing strategies" =57,
                         "27458221 Failure of the amikacin, cefoxitin, and clarithromycin combination regimen for treating pulmonary Mycobacterium abscessus infection" =58,
                         "27458215 Amikacin Optimal Exposure Targets in the Hollow-Fiber System Model of Tuberculosis" =59,
                         "27324776 In vitro activity of polymyxin B in combination with various antibiotics against extensively drug-resistant Enterobacter cloacae with decreased susceptibility to polymyxin B" =60,
                         "27270274 Relationship between fosfomycin exposure and amplification of Escherichia coli subpopulations with reduced susceptibility in a hollow-fiber infection model" =61,
                         "27231278 Effect of different renal function on antibacterial effects of piperacillin against Pseudomonas aeruginosa evaluated via the hollow-fibre infection model and mechanism-based modelling" =62,
                         "27216055 Thioridazine as chemotherapy for Mycobacterium avium complex diseases" =63,
                         "27067330 Paradoxical effect of polymyxin B: High drug exposure amplifies resistance in Acinetobacter baumannii" =64,
                         "27067317 Moxifloxacin's Limited Efficacy in the Hollow-Fiber Model of Mycobacterium abscessus Disease" =65,
                         "26926649 Tigecycline Is Highly Efficacious against Mycobacterium abscessus Pulmonary Disease." =66,
                         "26711763 Sequential Evolution of Vancomycin-Intermediate Resistance Alters Virulence in Staphylococcus aureus: Pharmacokinetic/Pharmacodynamic Targets for Vancomycin Exposure" =67,
                         "26643339 Amikacin Pharmacokinetics/Pharmacodynamics in a Novel Hollow-Fiber Mycobacterium abscessus Disease Model" =68,
                         "26530386 Preclinical Evaluations To Identify Optimal Linezolid Regimens for Tuberculosis Therapy" =69,
                         "26224771 Strategic Regulatory Evaluation and Endorsement of the Hollow Fiber Tuberculosis System as a Novel Drug Development Tool" =70,
                         "26224770 The Hollow Fiber System Model in the Nonclinical Evaluation of Antituberculosis Drug Regimens" =71,
                         "26224767 Systematic analysis of hollow fiber model of tuberculosis experiments" =72,
                         "26224766 Hollow Fiber System Model for Tuberculosis: The European Medicines Agency Experience" =73,
                         "26124169 Pharmacodynamics of fosfomycin: Insights into clinical use for antimicrobial resistance" =74,
                         "25870053 Pharmacokinetic Determinants of Virological Response to Raltegravir in the In Vitro Pharmacodynamic Hollow-Fiber Infection Model System" =75,
                         "25712313 Colistin and doripenem combinations against Pseudomonas aeruginosa: profiling the time course of synergistic killing and prevention of resistance." =76,
                         "25691628 In vitro pharmacodynamics of various antibiotics in combination against extensively drug-resistant Klebsiella pneumoniae" =77,
                         "25645830 Rapid drug tolerance and dramatic sterilizing effect of moxifloxacin monotherapy in a novel hollow-fiber model of intracellular Mycobacterium kansasii disease." =78,
                         "25362196 Combination treatment with meropenem plus levofloxacin is synergistic against pseudomonas aeruginosa infection in a murine model of Pneumonia" =79,
                         "25182633 Evaluation of meropenem regimens suppressing emergence of resistance in acinetobacter baumannii with human simulated exposure in an in vitro intravenous-infusion hollow-fiber infection model" =80,
                         "25070105 Relationship between ceftolozane-tazobactam exposure and selection for Pseudomonas aeruginosa resistance in a hollow-fiber infection model" =81,
                         "25003557 Analysis of combination drug therapy to develop regimens with shortened duration of treatment for tuberculosis." =82,
                         "24687496 Population Pharmacokinetic/Pharmacodynamic Analysis of the Bactericidal Activities of Sutezolid (PNU-100480) and Its Major Metabolite against Intracellular Mycobacterium tuberculosis in Ex Vivo Whole-Blood Cultures of Patients with Pulmonary Tuberculosis" =83,
                         "24041894 Hollow-Fiber Pharmacodynamic Studies and Mathematical Modeling To Predict the Efficacy of Amoxicillin for Anthrax Postexposure Prophylaxis in Pregnant Women and Children" =84
                         
                       ),
                       selected = 85)),
    )),
    
    
  
  
  shinyjs::hidden(fluidRow(id="form2",
    
    hr(),
    h4("PICO framework: Population"),
    hr(),
    
    column(6, offset =0.5,
           
           radioButtons('aim', label = "Main aim of using the HFIM", 
                        choices = c(
                          "drug development"=0, 
                          "investigating drug combinations"=1, 
                          "investigating antimicrobial resistance"=2, 
                          "investigating multi-infection interactions"=3,
                          "modelling IV or extravascular timecourses" = 4, 
                          "investigating intracellular pathogens"= 5, 
                          "pharmacodynamic interactions"= 6,
                          "Other" = 7), 
                        selected = 7),
           conditionalPanel(condition = "input.aim == 7",
                            textInput(inputId = "otheraim",
                                      label   = "Other aim in one sentence",
                                      value = ""))
           
    ), # close column 
    
    column(4, offset =0.5,
           selectInput('organism', label = 'Organism investigated', choices = c("Bacteria" = 0, "Parasite" = 1, "Fungi" = 2, "Protozoa"= 3, "Viruses" = 5, "Other"= 4), selected = 0),
           
           br(), 
           
           conditionalPanel(condition = "input.organism == 0",
                            selectInput(inputId = "species",
                                        label   = "Bacterial species investigated",
                                        choices = c(
                                          "Acinetobacter baumannii" = 0,
                                          "Bacillus" = 1,
                                          "Bordetella" = 2,
                                          "Brucella" = 3,
                                          "Campylobacter" = 4,
                                          "Chlamydia" = 5,
                                          "Clostridium" = 6,
                                          "Enterobacter cloacae" = 7,
                                          "Enterococcus" = 8,
                                          "Escherichia coli" = 9,
                                          "Haemophilus" = 10,
                                          "Helicobacter pylori" = 11,
                                          "Klebsiella pneumoniae" = 12,
                                          "Lactobacillus" = 13,
                                          "Legionella pneumophila" = 14,
                                          "Listeria monocytogenes" = 15,
                                          "Micrococcus luteus" = 16,
                                          "Moraxella catarrhalis" = 17,
                                          "Mycobacterium" = 18,
                                          "Mycoplasma" = 19,
                                          "Neisseria" = 20,
                                          "Pasteurella" = 21,
                                          "Pseudomonas aeruginosa" = 22,
                                          "Rickettsia" = 23,
                                          "Salmonella" = 24,
                                          "Serratia marcescens" = 25,
                                          "Shigella dysenteriae" = 26,
                                          "Staphylococcus" = 27,
                                          "Streptococcus" = 28,
                                          "Treponema" = 29,
                                          "Vibrio" = 30,
                                          "Yersinia" = 31,
                                          "Yersinia" = 32,
                                          "Other" = 33), 
                                        selected = 33),
                            br(),
                            conditionalPanel(condition = "input.species == 33",
                                             textInput(inputId = "otherbacteria",
                                                       label   = "Other bacteria species investigated",
                                                       value = ""))),
           
           conditionalPanel(condition = "input.organism == 1",
                            textInput(inputId = "parasite",
                                      label   = "Parasite species investigated",
                                      value = "")),
           
           conditionalPanel(condition = "input.organism == 2",
                            textInput(inputId = "fungi",
                                      label   = "Fungi species investigated",
                                      value = "")),
           
           conditionalPanel(condition = "input.organism == 3",
                            textInput(inputId = "protazoa",
                                      label   = "Protazoa species investigated",
                                      value = "")),
           
           conditionalPanel(condition = "input.organism == 4",
                            textInput(inputId = "other",
                                      label   = "Other organism investigated",
                                      value = "")),
           
           br(),
           textInput('comments1', label = 'Any other comments on PICO population', value = "" ))
    
  )), # to close fluid row 
  
  shinyjs::hidden(fluidRow(id="form3",
    
    hr(),
    h4("PICO framework: Intervention"),
    hr(),
    
    column(6, offset = 0.5,
           selectInput('antibiotic', label = 'Antibiotic investigated', 
                       choices = c(
                         "Amikacin" = 1,
                         "Amoxicillin" = 2,
                         "Ampicillin" = 3,
                         "Azithromycin" = 4,
                         "Aztreonam" = 5,
                         "Cefepime" = 6,
                         "Cefixime" = 7,
                         "Cefmetazole" = 8,
                         "Cefotaxime" = 9,
                         "Cefoxitin" = 10,
                         "Cefpirome" = 11,
                         "Ceftaroline" = 12,
                         "Ceftazidime" = 13,
                         "Ceftobiprole" = 14,
                         "Ceftriaxone" = 15,
                         "Cefuroxime" = 16,
                         "Chloramphenicol" = 17,
                         "Ciprofloxacin" = 18,
                         "Clarithromycin" = 19,
                         "Clindamycin" = 20,
                         "Doxycycline" = 21,
                         "Ertapenem" = 22,
                         "Erythromycin" = 23,
                         "Gentamicin" = 24,
                         "Levofloxacin" = 25,
                         "Linezolid" = 26,
                         "Lomefloxacin" = 27,
                         "Meropenem" = 28,
                         "Moxifloxacin" = 29,
                         "Nadifloxacin" = 30,
                         "Nalidixic acid" = 31,
                         "Penicillin" = 32,
                         "Piperacillin" = 33,
                         "Polymyxin B" = 34,
                         "Rifampin" = 35,
                         "Streptomycin" = 36,
                         "Sulfamethoxazole" = 37,
                         "Tetracycline" = 38,
                         "Tigecycline" = 39,
                         "Tobramycin" = 40,
                         "Trimethoprim-Sulfamethoxazole" = 41,
                         "Vancomycin" = 42,
                         "Not applicable"=43,
                         "Combination" =44,
                         "Other"=45), 
                       selected = 45),  
           
           br(),
           conditionalPanel(condition = "input.antibiotic == 45",
                            textInput(inputId = "otherantibiotics",
                                      label   = "Other Antibiotic investigated",
                                      value = "")),
           
           conditionalPanel(condition = "input.antibiotic == 44",
                            textInput(inputId = "othercombination",
                                      label   = "Antibiotic combination investigated",
                                      value = "")),
           
           
           checkboxGroupInput('PK', label = 'Select all the simulated pharmacokinetics (PK) reported?', 
           choices = c ("mimicked dose"= 0, "t1/2" = 1, "Cmax" = 2, "Tmax"=3, "Not applicable"=4, "No simulated PK reported"=5), 
                      selected = 5), 
           
           
           
           br(),
           
           selectInput('administration', label = "Antibiotic administration to the HF system", 
                       choices = c (
                         "Injection bolus" = 0, 
                         "Syringe infusion" = 1, 
                         "Not applicable" =2,
                         "Other" =3),
                       selected = 3),
           conditionalPanel(condition = "input.administration == 3",
                            textInput(inputId = "otheradministration",
                                      label   = "Other Antibiotic administration",
                                      value = "")),
           br(),
           selectInput('microbialmeasurments', label = 'Quantification of microbial innoculum reported?', choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           selectInput('inoculum', label = 'Microbial inoculum quantification method i.e. how they calculated PD target', choices = c("Macfarland standard" = 0, "OD 600" = 1, "CFUs" = 2, "Not applicable" = 3, "Other" = 4), selected = 0)
        
    ),
    
    column(4, offset = 0.5,

           selectInput('compartments', label = "Number of diluent reservoirs (distribution compartments)", choices = c ("1" = 0, "2" = 1, "≥3" =2, "Other"=3), selected = 3),
           br(),
           radioButtons('control', label = "Control experiments conducted, i.e drug free experiment", choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           selectInput('repeatstech', label = 'Number of techincal repeats, i.e repeat testing of endpoints for example MIC ', choices = c("1" = 0, "2" = 1, "≥3" = 2), selected = 2),
           br(),
           selectInput('repeatsbio', label = 'Number of biological repeats i.e. repeat run of organism investigated', choices = c("1" = 0, "2" = 1, "≥3" = 2), selected = 2),
           br(),
           numericInput('timeline', label = "Experiment duration in days", value = ""),
           br(),
           textInput('comments2', label = 'Any other comments on PICO intervention', value = ))
  )), # to close fluid row
  
  
  shinyjs::hidden(fluidRow(id="form4",
    
    br(),
    hr(),
    h4("PICO framework: Outcome"),
    hr(),
    
    column(6, offset =0.5,
           selectInput('killing', label = "Microbial killing quantification", choices = c ("Static time-kill" = 0, "Log1" = 1, "Log2" =2, "AUC"=3, "Not applicable" = 4), selected = 0),
           br(),
           radioButtons('resistance', label = 'Phenotypic antimicrobial resistance measured', choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           radioButtons('genotyping', label = 'Genetic characterisation', choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2)
           
    ),
    
    column(4, offset=0.5,
           radioButtons('CFU', label = "CFU quantified", choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           radioButtons('viable', label = 'Viable dead/live cell counts', choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           textInput('comments3', label = 'Any other comments on PICO outcome', value = )
    
      
    ))), #close fluidrow
  
  
  shinyjs::hidden(fluidRow(id="form5",
    
    br(),
    hr(),
    h4("PICO framework: HFIM settings"),
    hr(),
    
    column(6, offset =0.5,
           
           selectInput('cartridge', label = "Cartridge type", choices = c ("Proprietary" = 0, "Dialysis" = 1, "Not reported" =2, "Not applicable" =3, "Other" =4), selected = 3),
           br(),
           conditionalPanel(condition = "input.cartridge == 4",
                            textInput(inputId = "othercartridge",
                                      label   = "Other cartridge type",
                                      value = "")),
           selectInput('fibretype', label = "Fibre type", choices = c ("Polysulfone" = 0, "Cellulosic" = 1, "Not reported" =2, "Not applicable" =3, "Other" =4), selected = 3),
           br(),
           conditionalPanel(condition = "input.Fibretype == 4",
                            textInput(inputId = "otherFibretype",
                                      label   = "Other fibre type",
                                      value = "")),
           selectInput('HFtubing', label = "HF tubing type", choices = c ("PVC" = 0, "Pharmed" = 1, "Not reported" =2, "Not applicable" =3, "Other" =4 ), selected = 3),
           br(),
           conditionalPanel(condition = "input.HFtubing == 4",
                            textInput(inputId = "othertubing",
                                      label   = "Other tubing type",
                                      value = "")),
           radioButtons('pore', label = 'HF tubing bore size reported?', choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           radioButtons('length', label = 'HF tubing length reported?', choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           radioButtons('filtration', label = "Filtration suitability reported", choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2)
    ),
    
    column(4, offset=0.5,
           radioButtons('media', label = "Descripion of media provided?", choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           radioButtons('dynamics', label = "Peristaltic pump settings reported?", choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           radioButtons('ph', label = "pH monitored?", choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           radioButtons('contamination', label = "Contamination measured?", choices = c("Yes" = 0, "No" = 1, "Not applicable" = 2), selected = 2),
           br(),
           radioButtons('modelling', label = "What modelling approach was used?", 
                        choices = c (
                          "NONMEM" = 0, 
                          "ADAPT" = 1, 
                          "Pmetrics" =2,
                          "nlmixr"= 3,
                          "Not applicable" =4,
                          "Other" =5),
                        selected = 5),
           conditionalPanel(condition = "input.modelling == 5",
                            textInput(inputId = "othermodelling",
                                      label   = "Other modelling approach",
                                      value = "")),
           br(),
           textInput('comments4', label = 'Any other comments on HF set up', value = )
    ))), # close fluidrow
  
  
  
  shinyjs::hidden(fluidRow(id="form6",
                           useShinyalert(),
                           (actionButton("submit", "Submit")),
    
      
    hr(),
    h5("Thank you for your help :) "),
    hr(),
    date()
  )) # close fluidrow
  
  
) # bracket to close fluid page


#### Shiny app user server ####
source("server.R")


#### Run the app ####
shinyApp(ui = ui, server = server, options = list(height=1080))

