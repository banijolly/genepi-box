<?php
//$Tag = ['B.1.1.7', 'B.1.351', 'B.1.617.2', 'B.1.1.529', 'P.1', 'AY.1', 'AY.2', 'AY.3', 'AY.4', 'AY.12', 'AY.16', 'AY.20','AY.33','AY.37','AY.38','AY.39','AY.119', 'AY.43', 'AY.122', 'BA.1', 'B.1.1.529', 'BA.2'];
//@$Taglist = $Tag;

$postdata = file_get_contents("php://input");
$request = json_decode($postdata);
@$Taglist = json_decode($request->Tag);
// php function to convert csv to json format
function csvToJson($fname) {
    // open csv file
    if (!($fp = fopen($fname, 'r'))) {
        die("Can't open file...");
    }

    //read csv headers
    $key = fgetcsv($fp,"1024",",");

    // parse csv rows into array
    $json = array();

    while ($row = fgetcsv($fp,"1024")) {
        $json[] = array_combine($key, $row);
    }

    // release file handle
    fclose($fp);

    // encode array to json
    return json_encode($json);
}


$mydata = csvToJson("../LineageTracker/metadata-lineagetracker_master.csv");
$json = json_decode($mydata);

 $datesmp = array();

 foreach ($json as $k => $v) {
   array_push($datesmp, $v->Lineage);
 }
  echo json_encode($datesmp);

  ?>
