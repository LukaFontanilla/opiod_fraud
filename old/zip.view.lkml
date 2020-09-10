view: zip {
}

view: zip_raw {

  dimension: zip_id {
    type: number
    primary_key: yes
  }

  dimension: zip_code {
    type: number
  }

  dimension: lat {
    type: number
  }

  dimension: long {
    type: number
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:

SELECT 16 as Zip_id, 32828 as zip_code, 28.529031 as lat, -81.166578 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 17 as Zip_id, 32822 as zip_code, 28.489898 as lat, -81.290154 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 15 as Zip_id, 32825 as zip_code, 28.518028 as lat, -81.229003 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 18 as Zip_id, 32837 as zip_code, 28.379425 as lat, -81.429129 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 14 as Zip_id, 32839 as zip_code, 28.488069 as lat, -81.407208 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 19 as Zip_id, 32808 as zip_code, 28.58011 as lat, -81.4443 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 13 as Zip_id, 32818 as zip_code, 28.586751 as lat, -81.486895 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 20 as Zip_id, 32835 as zip_code, 28.51873 as lat, -81.486227 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 12 as Zip_id, 32824 as zip_code, 28.384164 as lat, -81.33304 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 21 as Zip_id, 32811 as zip_code, 28.521568 as lat, -81.447421 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 11 as Zip_id, 32817 as zip_code, 28.591012 as lat, -81.243652 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 22 as Zip_id, 32812 as zip_code, 28.483991 as lat, -81.322838 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 10 as Zip_id, 32810 as zip_code, 28.625101 as lat, -81.42769 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 23 as Zip_id, 32807 as zip_code, 28.554337 as lat, -81.29948 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 9 as Zip_id, 32826 as zip_code, 28.579737 as lat, -81.188811 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 24 as Zip_id, 32809 as zip_code, 28.462146 as lat, -81.385959 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 8 as Zip_id, 32819 as zip_code, 28.453375 as lat, -81.472395 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 25 as Zip_id, 32806 as zip_code, 28.511789 as lat, -81.360438 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 7 as Zip_id, 32805 as zip_code, 28.52938 as lat, -81.403667 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 26 as Zip_id, 32821 as zip_code, 28.381999 as lat, -81.479599 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 6 as Zip_id, 32803 as zip_code, 28.555829 as lat, -81.346291 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 27 as Zip_id, 32829 as zip_code, 28.484569 as lat, -81.246089 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 5 as Zip_id, 32804 as zip_code, 28.57829 as lat, -81.396428 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 28 as Zip_id, 32836 as zip_code, 28.407659 as lat, -81.519798 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 4 as Zip_id, 32832 as zip_code, 28.40318 as lat, -81.191537 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 29 as Zip_id, 32801 as zip_code, 28.541774 as lat, -81.374351 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 3 as Zip_id, 32833 as zip_code, 28.494294 as lat, -81.083265 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 30 as Zip_id, 32820 as zip_code, 28.576844 as lat, -81.139725 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 2 as Zip_id, 32827 as zip_code, 28.415581 as lat, -81.29899 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 31 as Zip_id, 32814 as zip_code, 28.572584 as lat, -81.322358 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 1 as Zip_id, 32831 as zip_code, 28.474506 as lat, -81.131105 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 32 as Zip_id, 32830 as zip_code, 28.383036 as lat, -81.573708 as long, 'ORLANDO' as City, 'FL' as State UNION ALL
SELECT 33 as Zip_id, 33161 as zip_code, 25.893664 as lat, -80.181539 as long, 'Miami' as City, 'FL' as State UNION ALL
SELECT 34 as Zip_id, 33136 as zip_code, 25.787182 as lat, -80.204722 as long, 'Miami' as City, 'FL' as State UNION ALL
SELECT 35 as Zip_id, 33615 as zip_code, 28.005103 as lat, -82.580284 as long, 'Tampa' as City, 'FL' as State UNION ALL
SELECT 36 as Zip_id, 33619 as zip_code, 27.935372 as lat, -82.37869 as long, 'Tampa' as City, 'FL' as State UNION ALL
SELECT 37 as Zip_id, 33771 as zip_code, 27.906822 as lat, -82.758784 as long, 'Clearwater' as City, 'FL' as State UNION ALL
SELECT 38 as Zip_id, 33761 as zip_code, 28.033061 as lat, -82.724374 as long, 'Clearwater' as City, 'FL' as State UNION ALL
SELECT 39 as Zip_id, 32244 as zip_code, 30.217669 as lat, -81.752545 as long, 'Jacksonville' as City, 'FL' as State UNION ALL
SELECT 40 as Zip_id, 32216 as zip_code, 30.277467 as lat, -81.582904 as long, 'Jacksonville' as City, 'FL' as State
;;
  }
}
