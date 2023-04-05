<?php
    header("Content-Type: application/json; charset=UTF-8");
    $drugs = json_decode(file_get_contents("https://drugscanner-ae525-default-rtdb.asia-southeast1.firebasedatabase.app/drugs.json"), true);

    if (isset($_GET['id'])) {
        if (array_key_exists($_GET['id'], $drugs)) {
            print_r(json_encode($drugs[$_GET['id']], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
        } else {
            die("{}");
        }
    } else if (isset($_GET)) {
        $search = isset($_GET['search']) ? strtolower(trim($_GET['search'])) : null;
        $color = isset($_GET['color']) ? strtolower(trim($_GET['color'])) : null;
        $shape = isset($_GET['shape']) ? strtolower(trim($_GET['shape'])) : null;
        $type = isset($_GET['type']) ? strtolower(trim($_GET['type'])) : null;
        $result = array();
        $lst = array_keys($drugs);
        for ($i = 0; $i < sizeof($lst); $i++) {
            $matched = 0;
            $drug = $drugs[$lst[$i]];
            if ($search == null) {
                $matched = 1;
            } else {
                if (strpos(strtolower(trim($drug['name'])), $search) !== false) {
                    $matched = 1;
                } else {
                    foreach($drug['alias'] as $alias) {
                        if (strpos(strtolower(trim($alias)), $search) !== false) {
                            $matched = 1;
                            break;
                        }
                    }
                }
            }

            if ($matched == 1) {
                if ($color != null && $color != "variant") {
                    if (is_array($drug['appearance']['color'])) {
                        $matched = 0;
                        foreach($drug['appearance']['color'] as $c) {
                            if ($c == "variant") {
                                $matched = 1;
                                break;
                            }
                            if ($c == $color) {
                                $matched = 1;
                                break;
                            }
                        }
                    }
                    else if ($drug['appearance']['color'] != $color && $drug['appearance']['color'] != "variant") {
                        continue;
                    }
                }
                if (($shape != null && $shape != "variant" && $drug['appearance']['shape'] != $shape) || $drug['appearance']['shape'] == "variant") {
                    continue;
                }
                if ($type != null) {
                    $matched = 0;
                    foreach($drug['type'] as $t) {
                        if ($t == $type) {
                            $matched = 1;
                            break;
                        }
                    }
                }
                if ($matched == 1)
                    $result[$lst[$i]] = $drug;
            }
        }
        if (sizeof($result) == 0)
            die("{}");
        print_r(json_encode($result, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
    } else {
        print_r(json_encode($drugs, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
    }
?>