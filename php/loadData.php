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
//echo json_encode($mydata);



  $jd = json_decode($mydata);
  //  echo json_encode($jd);

 $json = $jd;

$output_array = array();
$outarray1 = array();

foreach($json as $key => $val) {
    $output_array[] = $val;
}
//echo json_encode($output_array);die;
$output['maindata'] = $output_array;

$userdb = json_encode($output);
$json = json_decode($userdb);
//echo json_encode($json);

$arraymain[] = null;
$arraydate[] = null;
$arraymonth[] = null;
$arrayyear[] = null;
//echo json_encode($json->maindata); die;
$output_replace = array();
foreach ($json->maindata as $item) {
    $valzygo = $item->Date_of_Sample_Collection;
    $replace_val = str_replace('-', '-', $valzygo);
    $output_replace[] = $replace_val;
}

$spitarray = json_encode($output_replace);
//echo json_encode($spitarray);

$arrayvarrr[] = null;
$val_azygo = array();
$merge_keyval = array();

foreach ($output_replace as $itemmain => $valmain) {
    $varrr = explode("-", $valmain);
    list($year_val,$month_val,$date_val) =  $varrr;
    $month = $month_val.'-'.$year_val ;
    $year = $year_val;
    $merge_keyval[] = $month;
}

$merge_keyval = array_map(function($tag) {
    return array(
        'graph_data' => $tag
    );
}, $merge_keyval);

$out = array();
foreach ($merge_keyval as $key => $value){
    $outmerge_val = (object)array_merge((array)$output_array[$key], (array)$value);
    $out[] = $outmerge_val;
}

$output['mydata'] = $out;

$group_arr = json_encode($out);
$jd = json_decode($group_arr);
        $arr_all_lineage = [];
        foreach ($jd as $k => $v) {
            if( ( in_array( $v->Lineage, $Taglist ) ))
            {
                if ( !( in_array( $v->Lineage, $arr_all_lineage ) ) ) {
                    array_push( $arr_all_lineage, $v->Lineage );
                }
            }
        }
        $arr = [];
        foreach ($jd as $k => $v) {

            if (!(array_key_exists("".$v->graph_data, $arr))) {
                $arr["".$v->graph_data] = ["graph_data" => "".$v->graph_data];

                foreach ($arr_all_lineage as $k_aal => $v_all) {
                    $arr["".$v->graph_data]["".$v_all] = 0;
                }
            }

            if ( array_key_exists( "".$v->Lineage, $arr["".$v->graph_data] ) ) {
                $arr["".$v->graph_data]["".$v->Lineage]++;
            }
            else{
                $arr["".$v->graph_data]["Other"]++;
            }
        }
        $arr_output = [];

        foreach ($arr as $k => $v) {
            array_push($arr_output, $v);
        }

        $str = json_encode($arr_output);
        echo $str;

 ?>
