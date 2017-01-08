player addAction ["View Distance Settings",TAWVD_fnc_openTAWVD,[],-98,false,false,"",''];

player enableFatigue False;  
player addEventHandler ["Respawn", {player enableFatigue false}];


{_x addCuratorEditableObjects [[player],FALSE];} count allCurators;


//player addAction ["", ""];