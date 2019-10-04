view: drug {
  extends: [drug_raw]
}

view: drug_raw {

  dimension: drug_id {
    primary_key: yes
    type: number
  }

  dimension: drug_name {
    link: {
      label: "Drug Therapy Deep Dive"
      url: "https://demoexpo.looker.com/dashboards/173"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  dimension: opioid_drug {
  }

  dimension: med {
    type: number
    sql: ${TABLE}.MED ;;
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:

SELECT 1 as drug_id,  'OXYCONTIN' as drug_name_simple, 'METHADONE HCL' as drug_name, 'Yes' as opioid_drug, 85 as MED UNION ALL
SELECT 2 as drug_id,  'LISINOPRIL' as drug_name_simple, 'METOPROLOL TARTRATE' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 3 as drug_id,  'OXYCONTIN' as drug_name_simple, 'OXYCONTIN' as drug_name, 'Yes' as opioid_drug, 100 as MED UNION ALL
SELECT 4 as drug_id,  'LISINOPRIL' as drug_name_simple, 'FUROSEMIDE' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 5 as drug_id,  'OMEPRAZOLE' as drug_name_simple, 'SIMVASTATIN' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 6 as drug_id,  'OMEPRAZOLE' as drug_name_simple, 'OMEPRAZOLE' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 7 as drug_id,  'FENTANYL' as drug_name_simple, 'FENTANYL' as drug_name, 'Yes' as opioid_drug, 200 as MED UNION ALL
SELECT 8 as drug_id,  'LISINOPRIL' as drug_name_simple, 'LISINOPRIL' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 9 as drug_id,  'FENTANYL' as drug_name_simple, 'OXYCODONE-ACETAMINOPHEN' as drug_name, 'Yes' as opioid_drug, 50 as MED UNION ALL
SELECT 10 as drug_id, 'FENTANYL' as drug_name_simple, 'HYDROCODONE-ACETAMINOPHEN' as drug_name, 'Yes' as opioid_drug, 100 as MED UNION ALL
SELECT 11 as drug_id, 'HYDROCODONE-ACETAMINOPHEN' as drug_name_simple, 'TRAMADOL HCL' as drug_name, 'Yes' as opioid_drug, 80 as MED UNION ALL
SELECT 12 as drug_id, 'LISINOPRIL' as drug_name_simple, 'LEVOTHYROXINE SODIUM' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 13 as drug_id, 'LISINOPRIL' as drug_name_simple, 'AMLODIPINE BESYLATE' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 14 as drug_id, 'HYDROCODONE-ACETAMINOPHEN' as drug_name_simple, 'OXYCODONE HCL' as drug_name, 'Yes' as opioid_drug, 125 as MED UNION ALL
SELECT 15 as drug_id, 'ATORVASTATIN CALCIUM' as drug_name_simple, 'ATORVASTATIN CALCIUM' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 16 as drug_id, 'HYDROCODONE-ACETAMINOPHEN' as drug_name_simple, 'MORPHINE SULFATE ER' as drug_name, 'Yes' as opioid_drug, 130 as MED UNION ALL
SELECT 17 as drug_id, 'ACETAMINOPHEN-CODEINE' as drug_name_simple, 'ACETAMINOPHEN-CODEINE' as drug_name, 'Yes' as opioid_drug, 160 as MED UNION ALL
SELECT 18 as drug_id, 'ATORVASTATIN CALCIUM' as drug_name_simple, 'METFORMIN HCL' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 19 as drug_id, 'ATORVASTATIN CALCIUM' as drug_name_simple, 'GABAPENTIN' as drug_name, 'No' as opioid_drug, 0 as MED UNION ALL
SELECT 20 as drug_id, 'ACETAMINOPHEN-CODEINE' as drug_name_simple, 'TRAMADOL HCL-ACETAMINOPHEN' as drug_name, 'Yes' as opioid_drug, 200 as MED
;;
  }
}
