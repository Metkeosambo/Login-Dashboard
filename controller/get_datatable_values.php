<?php
include_once ("../connection/connect.php");
include_once ("../controller/util.php");
$connection=new Database();
$conn=$connection->dbConnection();
session_start();

/* ## Read value
$draw = $_POST['draw'];
$row = $_POST['start'];
$rowperpage = $_POST['length']; // Rows display per page
$columnIndex = $_POST['order'][0]['column']; // Column index
$columnName = $_POST['columns'][$columnIndex]['data']; // Column name
$columnSortOrder = $_POST['order'][0]['dir']; // asc or desc
$searchValue = $_POST['search']['value']; // Search value

$searchArray = array();

## Search 
$searchQuery = " ";
if($searchValue != ''){
   $searchQuery = " AND (create_date LIKE :create_date or 
        status LIKE :status OR 
        id LIKE :id ) ";
   $searchArray = array( 
        'create_date'=>"%$searchValue%", 
        'status'=>"%$searchValue%",
        'id'=>"%$searchValue%"
   );
}

## Total number of records without filtering
$stmt = $conn->prepare("SELECT COUNT(*) AS allcount FROM hr_suggestion_submited ");
$stmt->execute();
$records = $stmt->fetch();
$totalRecords = $records['allcount'];

## Total number of records with filtering
$stmt = $conn->prepare("SELECT COUNT(*) AS allcount FROM hr_suggestion_submited WHERE 1 ".$searchQuery);
$stmt->execute($searchArray);
$records = $stmt->fetch();
$totalRecordwithFilter = $records['allcount'];

## Fetch records
$stmt = $conn->prepare("SELECT * FROM hr_suggestion_submited WHERE 1 ".$searchQuery." ORDER BY ".$columnName." ".$columnSortOrder." LIMIT :limit,:offset");

// Bind values
foreach($searchArray as $key=>$search){
   $stmt->bindValue(':'.$key, $search,PDO::PARAM_STR);
}

$stmt->bindValue(':limit', (int)$row, PDO::PARAM_INT);
$stmt->bindValue(':offset', (int)$rowperpage, PDO::PARAM_INT);
$stmt->execute();
$empRecords = $stmt->fetchAll();

$data = array();

foreach($empRecords as $row){
   $data[] = array(
      "id"=>$row['id'],
      "create_date"=>$row['create_date'],
      "status"=>$row['status']
   );
}

## Response
$response = array(
   "draw" => intval($draw),
   "iTotalRecords" => $totalRecords,
   "iTotalDisplayRecords" => $totalRecordwithFilter,
   "aaData" => $data
);

echo json_encode($response); */
function get_total_all_records()
{
	$statement = $conn->prepare("SELECT * FROM hr_suggestion_submited");
	$statement->execute();
	$result = $statement->fetchAll();
	return $statement->rowCount();
}
$query = '';
$output = array();
$query .= "SELECT * FROM hr_suggestion_submited ";
if(isset($_POST["search"]["value"]))
{
	$query .= 'WHERE create_date LIKE "%'.$_POST["search"]["value"].'%" ';
	$query .= 'OR id LIKE "%'.$_POST["search"]["value"].'%" ';
}
if(isset($_POST["order"]))
{
	$query .= 'ORDER BY '.$_POST['order']['0']['column'].' '.$_POST['order']['0']['dir'].' ';
}
else
{
	$query .= 'ORDER BY id DESC ';
}
if($_POST["length"] != -1)
{
	$query .= 'LIMIT ' . $_POST['start'] . ', ' . $_POST['length'];
}
$statement = $conn->prepare($query);
$statement->execute();
$result = $statement->fetchAll();
$data = array();
$filtered_rows = $statement->rowCount();
foreach($result as $row)
{
	
	$sub_array = array();
	$sub_array[] = $row["id"];
	$sub_array[] = $row["create_date"];
	$sub_array[] = '<button type="button" name="update" id="'.$row["id"].'" class="btn btn-warning btn-xs update">Update</button>';
	$sub_array[] = '<button type="button" name="delete" id="'.$row["id"].'" class="btn btn-danger btn-xs delete">Delete</button>';
	$data[] = $sub_array;
}
$output = array(
	"draw"				=>	intval($_POST["draw"]),
	"recordsTotal"		=> $filtered_rows,
	"recordsFiltered"	=>	get_total_all_records(),
	"data"				=>	$data
);
echo json_encode($output);
?>