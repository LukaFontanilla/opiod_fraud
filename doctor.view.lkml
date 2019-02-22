view: doctor {

  dimension: doctor_id {
    hidden: yes
    type: number
    primary_key: yes
  }

  dimension: npi {
    label: "NPI"
    value_format_name: id
    type: number
    link: {
      label: "Doctor Dashboard"
      url: "https://demoexpo.looker.com/dashboards/66?NPI={{value}}"
      icon_url: "https://looker.com/favicon.ico"
    }
    action: {
      label: "Launch New Investigation"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Need for new investigation on {{value}}"
      }
      form_param: {
        name: "To Mailing List"
        required: yes
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Investigator -

        Given the high amount of risk seen in {{value}}, we strongly recommend beginning a new investigation.

        Best,
        "
      }
    }
  }

  dimension: first_name {}

  dimension: last_name {}

  dimension: name {
    sql: concat(${first_name}, concat(' ', ${last_name})) ;;
    link: {
      label: "WebMd"
      url: "https://doctor.webmd.com/results?so=&ln={{ value }}"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.webmd.com"
    }
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "NPPES Lookup"
      url: "https://npiregistry.cms.hhs.gov/registry/provider-view/1548431174"
      icon_url: "https://www.google.com/s2/favicons?domain_url=http://www.cms.gov"
    }
  }

  dimension: zip_code {
    type: number
    map_layer_name: us_zipcode_tabulation_areas
    value_format_name: id
    drill_fields: [specialty]
  }

  dimension: lat {
    type: number
    hidden: yes
  }

  dimension: long {
    type: number
    hidden: yes
  }

  dimension: city {
    drill_fields: [specialty]
  }

  dimension: state {
    map_layer_name: us_states
    drill_fields: [specialty]
  }

  dimension: specialty {
    drill_fields: [npi]
  }

  measure: count {
    label: "Count Doctors"
    type: count
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      npi,
      name,
      zip_code,
      state,
      count
    ]
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:

    SELECT
      a.doctor_id,
      concat('1003000',right(concat('002',cast(a.doctor_id as varchar(10))),3)) as NPI,
      a.first_name,
      a.last_name,
      b.zip_code,
      b.lat,
      b.long,
      b.city,
      b.state,
      CASE
        WHEN c.count_events > 13 then 'Anesthesiology'
        --WHEN c.count_events > 13 then 'Orthopedic Surgery'
        WHEN c.count_events > 6  then 'Neurosurgery'
        --WHEN c.count_events > 6  then 'Plastic and Reconstructive Surgery'
        --WHEN c.count_events > 3  then 'Vascular Surgery'
        WHEN c.count_events > 0  then 'General Surgery'
        WHEN c.count_events = 0  and right(cast(c.doctor_id as varchar(5)),1) in ('1','3','5', '2','4') then 'Family Practice'
        --WHEN c.count_events = 0  and right(cast(c.doctor_id as varchar(5)),1) in ('0','2','4') then 'Internal Medicine'
        WHEN c.count_events = 0  and right(cast(c.doctor_id as varchar(5)),1) in ('7','9','0','6','8') then 'Allergy/Immunology'
        --WHEN c.count_events = 0  and right(cast(c.doctor_id as varchar(5)),1) in ('6','8') then 'Dermatology'
        ELSE 'Family Practice'
      END as specialty
    FROM ${doctor_raw.SQL_TABLE_NAME} a
    JOIN ${zip_raw.SQL_TABLE_NAME} b
      ON a.zip_id = b.zip_id
    JOIN ${doctor_specialty.SQL_TABLE_NAME} c
      ON a.doctor_id = c.doctor_id
;;
  }

#       CASE
#         WHEN c.percent_opioid_claims > 0.79 and right(cast(c.doctor_id as varchar(5)),1) in ('1','3','5','7','9') then 'Anesthesiology'
#         WHEN c.percent_opioid_claims > 0.79 and right(cast(c.doctor_id as varchar(5)),1) not in ('1','3','5','7','9') then 'Orthopedic Surgery'
#         WHEN c.percent_opioid_claims > 0.59 and right(cast(c.doctor_id as varchar(5)),1) in ('1','3','5','7','9') then 'Neurosurgery'
#         WHEN c.percent_opioid_claims > 0.59 and right(cast(c.doctor_id as varchar(5)),1) not in ('1','3','5','7','9') then 'Plastic and Reconstructive Surgery'
#         WHEN c.percent_opioid_claims > 0.39 and right(cast(c.doctor_id as varchar(5)),1) in ('1','3','5','7','9') then 'Vascular Surgery'
#         WHEN c.percent_opioid_claims > 0.39 and right(cast(c.doctor_id as varchar(5)),1) not in ('1','3','5','7','9') then 'General Surgery'
#         WHEN c.percent_opioid_claims > 0.19 and right(cast(c.doctor_id as varchar(5)),1) in ('1','3','5','7','9') then 'Family Practice'
#         WHEN c.percent_opioid_claims > 0.19 and right(cast(c.doctor_id as varchar(5)),1) not in ('1','3','5','7','9') then 'Internal Medicine'
#         WHEN c.percent_opioid_claims >= 0 and   right(cast(c.doctor_id as varchar(5)),1) in ('1','3','5','7','9') then 'Allergy/Immunology'
#         WHEN c.percent_opioid_claims >= 0 and   right(cast(c.doctor_id as varchar(5)),1) not in ('1','3','5','7','9') then 'Dermatology'
#         ELSE 'Family Practice'
#       END as specialty

}

view: doctor_specialty  {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: claims_pre {
      column: doctor_id {}
      column: count_events { field: events.count_events }
      # column: percent_opioid_claims {}
    }
  }
  dimension: doctor_id {
    type: number
  }
#   dimension: percent_opioid_claims {
#     type: number
#   }
  dimension: count_events {
    type: number
  }
}

view: doctor_raw {

  derived_table: {
    datagroup_trigger: once_yearly
    sql:

    SELECT 1 as doctor_id, 'Pernell' as first_name, 'Kmieciak' as last_name, 23 as zip_id, -0.010512 as lat_add, 0.00556 as long_add UNION ALL
    SELECT 2 as doctor_id, 'Andie' as first_name, 'Omrod' as last_name, 12 as zip_id, 0.006429 as lat_add, 0.00155 as long_add UNION ALL
    SELECT 3 as doctor_id, 'Merl' as first_name, 'Speedy' as last_name, 21 as zip_id, 0.008997 as lat_add, 0.021913 as long_add UNION ALL
    SELECT 4 as doctor_id, 'Cathyleen' as first_name, 'Bardwell' as last_name, 9 as zip_id, -0.023704 as lat_add, -0.015235 as long_add UNION ALL
    SELECT 5 as doctor_id, 'Mikol' as first_name, 'Guillond' as last_name, 8 as zip_id, 0.012864 as lat_add, -0.010615 as long_add UNION ALL
    SELECT 6 as doctor_id, 'Sly' as first_name, 'Kingzet' as last_name, 10 as zip_id, -0.015433 as lat_add, -0.00823 as long_add UNION ALL
    SELECT 7 as doctor_id, 'Jeane' as first_name, 'Hussy' as last_name, 17 as zip_id, -0.013556 as lat_add, 0.018469 as long_add UNION ALL
    SELECT 8 as doctor_id, 'Dulci' as first_name, 'Wadworth' as last_name, 5 as zip_id, -0.006825 as lat_add, 0.009271 as long_add UNION ALL
    SELECT 9 as doctor_id, 'Deidre' as first_name, 'Sillars' as last_name, 15 as zip_id, -0.019871 as lat_add, 0.017341 as long_add UNION ALL
    SELECT 10 as doctor_id, 'Imojean' as first_name, 'Reasce' as last_name, 18 as zip_id, 0.007233 as lat_add, 0.003787 as long_add UNION ALL
    SELECT 11 as doctor_id, 'Lois' as first_name, 'Gosalvez' as last_name, 20 as zip_id, -0.007453 as lat_add, 0.017791 as long_add UNION ALL
    SELECT 12 as doctor_id, 'Normand' as first_name, 'Ledington' as last_name, 11 as zip_id, -0.002635 as lat_add, -0.019891 as long_add UNION ALL
    SELECT 13 as doctor_id, 'Sallyann' as first_name, 'Van den Hof' as last_name, 12 as zip_id, 0.000136 as lat_add, -0.005254 as long_add UNION ALL
    SELECT 14 as doctor_id, 'Brady' as first_name, 'Shepard' as last_name, 7 as zip_id, 0.017335 as lat_add, 0.002437 as long_add UNION ALL
    SELECT 15 as doctor_id, 'Margret' as first_name, 'Simonelli' as last_name, 15 as zip_id, -0.005681 as lat_add, -0.001094 as long_add UNION ALL
    SELECT 16 as doctor_id, 'Abbott' as first_name, 'Glayzer' as last_name, 19 as zip_id, -0.022166 as lat_add, -0.003564 as long_add UNION ALL
    SELECT 17 as doctor_id, 'Cornall' as first_name, 'Allpress' as last_name, 22 as zip_id, -0.010039 as lat_add, 0.002048 as long_add UNION ALL
    SELECT 18 as doctor_id, 'Melanie' as first_name, 'Goddard' as last_name, 8 as zip_id, -0.000603 as lat_add, -0.006146 as long_add UNION ALL
    SELECT 19 as doctor_id, 'Peggi' as first_name, 'Hrinishin' as last_name, 16 as zip_id, -0.004125 as lat_add, 0.00091 as long_add UNION ALL
    SELECT 20 as doctor_id, 'Archaimbaud' as first_name, 'Bernardi' as last_name, 11 as zip_id, 0.024838 as lat_add, 0.003727 as long_add UNION ALL
    SELECT 21 as doctor_id, 'Farica' as first_name, 'Edgerton' as last_name, 8 as zip_id, 0.012185 as lat_add, -0.000794 as long_add UNION ALL
    SELECT 22 as doctor_id, 'Olin' as first_name, 'Perroni' as last_name, 25 as zip_id, 0.023774 as lat_add, -0.013459 as long_add UNION ALL
    SELECT 23 as doctor_id, 'Cindee' as first_name, 'Kleynermans' as last_name, 19 as zip_id, 0.008078 as lat_add, -0.0167 as long_add UNION ALL
    SELECT 24 as doctor_id, 'Karlotte' as first_name, 'Fildery' as last_name, 22 as zip_id, 0.024841 as lat_add, -0.020173 as long_add UNION ALL
    SELECT 25 as doctor_id, 'Bruce' as first_name, 'Bocke' as last_name, 19 as zip_id, -0.023641 as lat_add, -0.012817 as long_add UNION ALL
    SELECT 26 as doctor_id, 'Esmeralda' as first_name, 'Allward' as last_name, 17 as zip_id, -0.004294 as lat_add, 0.0086 as long_add UNION ALL
    SELECT 27 as doctor_id, 'Christian' as first_name, 'McGuinley' as last_name, 17 as zip_id, 0.007038 as lat_add, 0.014529 as long_add UNION ALL
    SELECT 28 as doctor_id, 'Lavinia' as first_name, 'Elstob' as last_name, 20 as zip_id, 0.001396 as lat_add, 0.000202 as long_add UNION ALL
    SELECT 29 as doctor_id, 'Enid' as first_name, 'Gyse' as last_name, 10 as zip_id, 0.001894 as lat_add, -0.009686 as long_add UNION ALL
    SELECT 30 as doctor_id, 'Kitti' as first_name, 'Shackleton' as last_name, 12 as zip_id, 0.014479 as lat_add, -0.022824 as long_add UNION ALL
    SELECT 31 as doctor_id, 'Tova' as first_name, 'Lent' as last_name, 26 as zip_id, -0.012344 as lat_add, 0.01744 as long_add UNION ALL
    SELECT 32 as doctor_id, 'Jacquetta' as first_name, 'Casazza' as last_name, 9 as zip_id, -0.004155 as lat_add, 0.014358 as long_add UNION ALL
    SELECT 33 as doctor_id, 'Lita' as first_name, 'Lenormand' as last_name, 12 as zip_id, -0.016039 as lat_add, -0.018036 as long_add UNION ALL
    SELECT 34 as doctor_id, 'Mame' as first_name, 'Buxsey' as last_name, 12 as zip_id, -0.024656 as lat_add, -0.017748 as long_add UNION ALL
    SELECT 35 as doctor_id, 'Lanita' as first_name, 'Talloe' as last_name, 9 as zip_id, 0.022181 as lat_add, 0.021131 as long_add UNION ALL
    SELECT 36 as doctor_id, 'Dukie' as first_name, 'Rickell' as last_name, 31 as zip_id, 0.014078 as lat_add, 0.011916 as long_add UNION ALL
    SELECT 37 as doctor_id, 'Shem' as first_name, 'Monni' as last_name, 13 as zip_id, 0.009107 as lat_add, -0.01145 as long_add UNION ALL
    SELECT 38 as doctor_id, 'Tiffanie' as first_name, 'Flacke' as last_name, 17 as zip_id, 0.015585 as lat_add, 0.006984 as long_add UNION ALL
    SELECT 39 as doctor_id, 'Land' as first_name, 'Farloe' as last_name, 13 as zip_id, -0.005052 as lat_add, -0.022154 as long_add UNION ALL
    SELECT 40 as doctor_id, 'Meryl' as first_name, 'Ranns' as last_name, 23 as zip_id, -0.024008 as lat_add, -0.008693 as long_add UNION ALL
    SELECT 41 as doctor_id, 'Andrea' as first_name, 'Goodredge' as last_name, 19 as zip_id, 0.01776 as lat_add, 0.014341 as long_add UNION ALL
    SELECT 42 as doctor_id, 'Reena' as first_name, 'Thing' as last_name, 3 as zip_id, -0.008458 as lat_add, 0.009227 as long_add UNION ALL
    SELECT 43 as doctor_id, 'Waylon' as first_name, 'Povall' as last_name, 12 as zip_id, -0.021068 as lat_add, 0.01237 as long_add UNION ALL
    SELECT 44 as doctor_id, 'Vivienne' as first_name, 'Byre' as last_name, 9 as zip_id, -0.005623 as lat_add, 0.005534 as long_add UNION ALL
    SELECT 45 as doctor_id, 'Peria' as first_name, 'MacFayden' as last_name, 28 as zip_id, -0.001378 as lat_add, -0.01264 as long_add UNION ALL
    SELECT 46 as doctor_id, 'Alfonso' as first_name, 'Kinchington' as last_name, 17 as zip_id, 0.018343 as lat_add, 0.010125 as long_add UNION ALL
    SELECT 47 as doctor_id, 'Minni' as first_name, 'Jack' as last_name, 23 as zip_id, -0.021085 as lat_add, 0.015657 as long_add UNION ALL
    SELECT 48 as doctor_id, 'Nancie' as first_name, 'Biddlecombe' as last_name, 16 as zip_id, -0.001417 as lat_add, -0.004941 as long_add UNION ALL
    SELECT 49 as doctor_id, 'Rona' as first_name, 'Sans' as last_name, 19 as zip_id, -0.016096 as lat_add, -0.024003 as long_add UNION ALL
    SELECT 50 as doctor_id, 'Myrtia' as first_name, 'Pratty' as last_name, 17 as zip_id, -0.000795 as lat_add, -0.008999 as long_add UNION ALL
    SELECT 51 as doctor_id, 'Friederike' as first_name, 'Osbiston' as last_name, 11 as zip_id, 0.001942 as lat_add, 0.010924 as long_add UNION ALL
    SELECT 52 as doctor_id, 'Candis' as first_name, 'Tremmil' as last_name, 8 as zip_id, -0.002961 as lat_add, 0.012439 as long_add UNION ALL
    SELECT 53 as doctor_id, 'Thaxter' as first_name, 'Mogey' as last_name, 23 as zip_id, -0.015217 as lat_add, 0.017164 as long_add UNION ALL
    SELECT 54 as doctor_id, 'Drusi' as first_name, 'Fownes' as last_name, 13 as zip_id, 0.011573 as lat_add, 0.012091 as long_add UNION ALL
    SELECT 55 as doctor_id, 'Dot' as first_name, 'Poundford' as last_name, 15 as zip_id, 0.009242 as lat_add, 0.019348 as long_add UNION ALL
    SELECT 56 as doctor_id, 'Hy' as first_name, 'Ollerhad' as last_name, 13 as zip_id, 0.006535 as lat_add, 0.010191 as long_add UNION ALL
    SELECT 57 as doctor_id, 'Leisha' as first_name, 'Riggott' as last_name, 18 as zip_id, 0.006886 as lat_add, -0.013372 as long_add UNION ALL
    SELECT 58 as doctor_id, 'Phylys' as first_name, 'Sabathier' as last_name, 10 as zip_id, -0.019047 as lat_add, 0.002659 as long_add UNION ALL
    SELECT 59 as doctor_id, 'Benedicta' as first_name, 'MacCauley' as last_name, 13 as zip_id, 0.010999 as lat_add, 0.019649 as long_add UNION ALL
    SELECT 60 as doctor_id, 'Dulsea' as first_name, 'Player' as last_name, 20 as zip_id, -0.004287 as lat_add, 0.005616 as long_add UNION ALL
    SELECT 61 as doctor_id, 'Nichole' as first_name, 'Abbets' as last_name, 14 as zip_id, 0.019583 as lat_add, -0.024893 as long_add UNION ALL
    SELECT 62 as doctor_id, 'Richy' as first_name, 'Emons' as last_name, 14 as zip_id, 0.00491 as lat_add, -0.006467 as long_add UNION ALL
    SELECT 63 as doctor_id, 'Shane' as first_name, 'Gascoine' as last_name, 19 as zip_id, -0.018284 as lat_add, -0.016542 as long_add UNION ALL
    SELECT 64 as doctor_id, 'Selestina' as first_name, 'Flear' as last_name, 17 as zip_id, -0.011727 as lat_add, 0.016073 as long_add UNION ALL
    SELECT 65 as doctor_id, 'Travers' as first_name, 'Livett' as last_name, 14 as zip_id, -0.013105 as lat_add, 0.016076 as long_add UNION ALL
    SELECT 66 as doctor_id, 'Tamqrah' as first_name, 'Cutcliffe' as last_name, 20 as zip_id, -0.00387 as lat_add, -0.018207 as long_add UNION ALL
    SELECT 67 as doctor_id, 'Alan' as first_name, 'Castellaccio' as last_name, 4 as zip_id, -0.009917 as lat_add, 0.01188 as long_add UNION ALL
    SELECT 68 as doctor_id, 'Herbie' as first_name, 'Smale' as last_name, 7 as zip_id, -0.0188 as lat_add, -0.022564 as long_add UNION ALL
    SELECT 69 as doctor_id, 'Elias' as first_name, 'Jickles' as last_name, 18 as zip_id, -0.001809 as lat_add, 0.019783 as long_add UNION ALL
    SELECT 70 as doctor_id, 'Kip' as first_name, 'Byrde' as last_name, 16 as zip_id, 0.007112 as lat_add, -0.012273 as long_add UNION ALL
    SELECT 71 as doctor_id, 'Aggie' as first_name, 'Ham' as last_name, 20 as zip_id, 0.012844 as lat_add, -0.002049 as long_add UNION ALL
    SELECT 72 as doctor_id, 'Brigitte' as first_name, 'Gatesman' as last_name, 16 as zip_id, 0.005103 as lat_add, -0.016524 as long_add UNION ALL
    SELECT 73 as doctor_id, 'Conrade' as first_name, 'Slucock' as last_name, 14 as zip_id, -0.0213 as lat_add, 0.002025 as long_add UNION ALL
    SELECT 74 as doctor_id, 'Flossie' as first_name, 'Whitehair' as last_name, 12 as zip_id, -0.022248 as lat_add, 0.017505 as long_add UNION ALL
    SELECT 75 as doctor_id, 'Alonzo' as first_name, 'Farrall' as last_name, 5 as zip_id, -0.024801 as lat_add, -0.003542 as long_add UNION ALL
    SELECT 76 as doctor_id, 'Dedra' as first_name, 'McAllister' as last_name, 14 as zip_id, -0.002669 as lat_add, -0.008829 as long_add UNION ALL
    SELECT 77 as doctor_id, 'Benedick' as first_name, 'McKenzie' as last_name, 9 as zip_id, 0.003034 as lat_add, -0.005766 as long_add UNION ALL
    SELECT 78 as doctor_id, 'Jonathon' as first_name, 'Somner' as last_name, 10 as zip_id, 0.006348 as lat_add, -0.013754 as long_add UNION ALL
    SELECT 79 as doctor_id, 'Reena' as first_name, 'Collett' as last_name, 7 as zip_id, -0.003555 as lat_add, -0.001763 as long_add UNION ALL
    SELECT 80 as doctor_id, 'Niels' as first_name, 'Hast' as last_name, 14 as zip_id, -0.013397 as lat_add, -0.01485 as long_add UNION ALL
    SELECT 81 as doctor_id, 'Martainn' as first_name, 'Perell' as last_name, 28 as zip_id, -0.011964 as lat_add, 0.00347 as long_add UNION ALL
    SELECT 82 as doctor_id, 'Reed' as first_name, 'McGilvra' as last_name, 13 as zip_id, 0.016007 as lat_add, -0.01238 as long_add UNION ALL
    SELECT 83 as doctor_id, 'Sherye' as first_name, 'Weller' as last_name, 24 as zip_id, 0.009525 as lat_add, 0.020975 as long_add UNION ALL
    SELECT 84 as doctor_id, 'Devonne' as first_name, 'Lorent' as last_name, 15 as zip_id, 0.010476 as lat_add, -0.010688 as long_add UNION ALL
    SELECT 85 as doctor_id, 'Vale' as first_name, 'Shelper' as last_name, 15 as zip_id, -0.001946 as lat_add, -0.022813 as long_add UNION ALL
    SELECT 86 as doctor_id, 'Shina' as first_name, 'Weinham' as last_name, 15 as zip_id, -0.024303 as lat_add, 0.017857 as long_add UNION ALL
    SELECT 87 as doctor_id, 'Barbara-anne' as first_name, 'Van Arsdall' as last_name, 20 as zip_id, 0.016299 as lat_add, -0.009684 as long_add UNION ALL
    SELECT 88 as doctor_id, 'Shaughn' as first_name, 'Mote' as last_name, 15 as zip_id, -0.018437 as lat_add, -0.021668 as long_add UNION ALL
    SELECT 89 as doctor_id, 'Ofella' as first_name, 'Greene' as last_name, 25 as zip_id, -0.016766 as lat_add, -0.007065 as long_add UNION ALL
    SELECT 90 as doctor_id, 'Klarrisa' as first_name, 'Saer' as last_name, 20 as zip_id, 0.000602 as lat_add, 0.018725 as long_add UNION ALL
    SELECT 91 as doctor_id, 'Clarisse' as first_name, 'Hollow' as last_name, 20 as zip_id, 0.017858 as lat_add, -0.017377 as long_add UNION ALL
    SELECT 92 as doctor_id, 'Anastasia' as first_name, 'Medmore' as last_name, 13 as zip_id, -0.018453 as lat_add, 0.002993 as long_add UNION ALL
    SELECT 93 as doctor_id, 'Claudina' as first_name, 'Wellstood' as last_name, 18 as zip_id, 0.021452 as lat_add, -0.022747 as long_add UNION ALL
    SELECT 94 as doctor_id, 'Tarrance' as first_name, 'Doonican' as last_name, 22 as zip_id, 0.009329 as lat_add, -0.004551 as long_add UNION ALL
    SELECT 95 as doctor_id, 'Livvyy' as first_name, 'Bilston' as last_name, 12 as zip_id, 0.006596 as lat_add, -0.01567 as long_add UNION ALL
    SELECT 96 as doctor_id, 'Latashia' as first_name, 'Shemmans' as last_name, -3 as zip_id, -0.020366 as lat_add, -0.000766 as long_add UNION ALL
    SELECT 97 as doctor_id, 'Stanislaus' as first_name, 'Trevorrow' as last_name, 8 as zip_id, -0.016482 as lat_add, 0.012673 as long_add UNION ALL
    SELECT 98 as doctor_id, 'Ellwood' as first_name, 'Chetwind' as last_name, 19 as zip_id, 0.005657 as lat_add, -0.011249 as long_add UNION ALL
    SELECT 99 as doctor_id, 'Marlon' as first_name, 'Gilhool' as last_name, 12 as zip_id, -0.003439 as lat_add, -0.022015 as long_add UNION ALL
    SELECT 100 as doctor_id, 'Hedwiga' as first_name, 'Twidle' as last_name, 19 as zip_id, -0.024462 as lat_add, 0.021782 as long_add

    ;;
  }
}
