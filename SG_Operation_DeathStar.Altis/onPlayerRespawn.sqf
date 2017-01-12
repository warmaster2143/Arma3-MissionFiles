player addAction ["View Distance Settings",TAWVD_fnc_openTAWVD,[],-98,false,false,"",''];

player enableFatigue False;  
player addEventHandler ["Respawn", {player enableFatigue false}];


//player addAction ["", ""];