<?php
header("Content-Type: application/json");

// Database connection
$conn = new mysqli("sql109.infinityfree.com", "if0_38046404", "pAW46Tb9TP1", "if0_38046404_mobile");

if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Connection failed: " . $conn->connect_error]);
    exit();
}

// Fetch exercises
$sql = "SELECT * FROM exercises";

$result = $conn->query($sql);

$exercises = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $exercises[] = $row; 
    }
    echo json_encode($exercises); 
} else {
    echo json_encode(["message" => "No exercises found"]);
}

$conn->close();
?>
