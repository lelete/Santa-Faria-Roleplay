#include 	<YSI\y_hooks>
#include 	<YSI\y_iterate>
#define		MAX_ITEMS	(1000)

forward GetItemID(itemid);
forward GetItemName(itemnamex[]);
forward GetItemWeight(itemweight);
forward GetItemModel(itemmodel);
forward GetItemVolume(itemvolume);
forward GetContainerLoadVolume(load);
forward GetContainerLoadWeight(load);
forward GetPlacedItemID(placeditem);
forward GetContainerSize(size);
forward GetContainerWeight(weight);
forward LoadPlacedItems();
forward IsItemContainer(itemid);

new Iterator:ItemsPlaced<MAX_ITEMS>;

enum e_PlacedItems
{
	pID,
	pContainer,
	pItem,
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	pInt,
	pVW
}

new PlacedItems[MAX_ITEMS][e_PlacedItems];

/***
   * AddItem(name[], weight, model, volume);
   * Adiciona um Item ao Banco de Dados;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock AddItem(name[], weight, model, volume)
{
    new string[128];
	mysql_format(db, string, 128, "INSERT INTO items (itemName, itemWeight, itemModel, itemVolume) VALUES('%e', '%i', '%i', '%i');", name, weight, model, volume);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * RemoveItem(itemid);
   * Removem um Item do Banco de DAdos;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock RemoveItem(itemid)
{
    new string[128];
	mysql_format(db, string, 128, "DELETE FROM `items` WHERE `itemID` = '%i';", itemid);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * SetItemName(itemid, itemname[24]);
   * Dá nome ao item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SetItemName(itemid, itemname[])
{
    new string[128];
	format(itemname, 24, "%s", itemname);
	mysql_format(db, string, 128, "UPDATE `items` SET `itemName` = '%e' WHERE `itemID` = '%i';", itemid, itemname);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * SetItemWeight(itemid, weight);
   * Dá peso ao item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SetItemWeight(itemid, weight)
{
    new string[128];
	mysql_format(db, string, 128, "UPDATE `items` SET `itemWeight` = '%i' WHERE `itemID` = '%i';", itemid, weight);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * SetItemModel(itemid, model);
   * Dá modelo ao item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SetItemModel(itemid, model)
{
    new string[128];
	mysql_format(db, string, 128, "UPDATE `items` SET `itemModel` = '%i' WHERE `itemID` = '%i';", itemid, model);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * SetItemVolume(itemid, volume);
   * Dá volume ao item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SetItemVolume(itemid, volume)
{
    new string[128];
	mysql_format(db, string, 128, "UPDATE `items` SET `itemVolume` = '%i' WHERE `itemID` = '%i';", itemid, volume);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * SetContainerVolume(containerid, volume);
   * Dá volume ao container;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SetContainerVolume(itemid, volume)
{
    new string[128];
	mysql_format(db, string, 128, "UPDATE `containers` SET `containerVolume` = '%i' WHERE `itemID` = '%i';", itemid, volume);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * SetContainerWeight(containerid, weight);
   * Dá volume ao container;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SetContainerWeight(itemid, weight)
{
    new string[128];
	mysql_format(db, string, 128, "UPDATE `containers` SET `containerWeight` = '%i' WHERE `itemID` = '%i';", itemid, weight);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * AddContainer(itemID, size, maxWeight);
   * Adiciona um Container ao Banco de Dados;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock AddContainer(itemID, size, maxWeight)
{
    new string[128];
	mysql_format(db, string, 128, "INSERT INTO containers (itemID, containerMaxSize, containerMaxWeight) VALUES('%i', '%i', '%i');", itemID, size, maxWeight);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * RemoveContainer(containerID);
   * Removem um Container do Banco de DAdos;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock RemoveContainer(containerID)
{
    new string[128];
	mysql_format(db, string, 128, "DELETE FROM `containers` WHERE `containerID` = '%i';", containerID);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * AddItemToContainer(containerID);
   * Adiciona um item em um Container ao Banco de Dados;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock AddItemToContainer(containerID, itemid)
{
    new string[128], itemweight, itemvolume, loadvolume, loadweight, size, weight;
	mysql_format(db, string, 128, "SELECT containerSize FROM containers WHERE containerID = '%i';", containerID);
	mysql_function_query(db, string, true, "GetContainerLoadVolume", "i", loadvolume);
	if(loadvolume == 0) return false;
	mysql_format(db, string, 128, "SELECT containerWeight FROM containers WHERE containerID = '%i';", containerID);
	mysql_function_query(db, string, true, "GetContainerLoadWeight", "i", loadweight);
	if(loadweight == 0) return false;
	mysql_format(db, string, 128, "SELECT itemVolume FROM items WHERE itemID = '%i';", itemid);
	mysql_function_query(db, string, true, "GetItemVolume", "i", itemvolume);
	if(itemvolume == 0) return false;
	mysql_format(db, string, 128, "SELECT itemWeight FROM items WHERE itemID = '%i';", itemid);
	mysql_function_query(db, string, true, "GetItemWeight", "i", itemweight);
	if(itemweight == 0) return false;
	mysql_format(db, string, 128, "SELECT containerMaxSize FROM containers WHERE containerID = '%i';", containerID);
	mysql_function_query(db, string, true, "GetContainerSize", "i", size);
	mysql_format(db, string, 128, "SELECT containerMaxWeight FROM containers WHERE containerID = '%i';", containerID);
	mysql_function_query(db, string, true, "GetContainerWeight", "i", weight);
	if(loadvolume+itemvolume > size || itemweight+loadweight > weight) return false;
	SetPlacedItemContainer(itemid, containerid);
	return true;
}

/***
   * RemoveItemFromContainer(containerID);
   * Removem um Container do Banco de DAdos;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock RemoveItemFromContainer(containerID, itemid)
{
    new string[128], itemvolume, itemweight;
	mysql_format(db, string, 128, "SELECT containerSize FROM containers WHERE containerID = '%i';", containerID);
	mysql_function_query(db, string, true, "GetContainerLoadVolume", "i", itemvolume);
	mysql_format(db, string, 128, "SELECT itemVolume FROM items WHERE itemID = '%i';", itemid);
	mysql_function_query(db, string, true, "GetItemVolume", "i", itemweight);
	if(itemweight == 0 || itemvolume == 0) return false;
	itemvolume -= itemweight;
	SetContainerVolume(containerid, itemvolume);
	mysql_format(db, string, 128, "SELECT containerWeight FROM containers WHERE containerID = '%i';", containerID);
	mysql_function_query(db, string, true, "GetContainerLoadWeight", "i", itemvolume);
	mysql_format(db, string, 128, "SELECT itemWeight FROM items WHERE itemID = '%i';", itemid);
	mysql_function_query(db, string, true, "GetItemWeight", "i", itemweight);
	itemvolume -= itemweight;
	SetContainerWeight(containerid, itemvolume);
	mysql_format(db, string, 128, "DELETE FROM `placeditems` WHERE `containerID` = '%i' AND `itemID` = '%i';", containerID, itemid);
	mysql_function_query(db, string, false, "", "");
	return true;
}

/***
   * AddPlacedItem(itemID, Float:posX, Float:posY, Float:posZ, int, vw, container);
   * Adiciona um Item ao jogo;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock PlaceItem(itemID, Float:posX, Float:posY, Float:posZ, int, vw, container = -1)
{
    new string[128];
	mysql_format(db, string, 128, "INSERT INTO containers (itemID, placePosX, placePosY, placePosZ, placeInt, placeVW) VALUES('%i', '%i', '%i');", itemID, size, maxWeight);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * RemoveContainer(containerID);
   * Removem um Container do Banco de DAdos;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock RemovePlacedItem(itemID)
{
    new string[128];
	mysql_format(db, string, 128, "DELETE FROM `placeditems` WHERE `placeID` = '%i';", itemID);
	mysql_function_query(db, string, false, "", "");
	PlacedItems[itemID][pID] = -1;
	PlacedItems[itemID][pContainer] = -1;
	PlacedItems[itemID][pItem] =-1;
	PlacedItems[itemID][pPosX] = 0;
	PlacedItems[itemID][pPosY] = 0;
	PlacedItems[itemID][pPosZ] = 0;
	PlacedItems[itemID][pInt] = 0;
	PlacedItems[itemID][pVW] = 0;
	Iter_Remove(ItemsPlaced, itemID);
	return 1;
}

stock ShowItemForPlayer(playerid, itemid)
{
	if(PlacedItems[itemid][pID] == -1) return false;
	new string[128], sname[24], iweight, ivolume, imodel;
	mysql_format(db, string, 128, "SELECT `itemName` FROM `items` WHERE `itemID` = '%i';", PlacedItems[itemid][pID]);
	mysql_function_query(db, string, true, "GetItemName", "s", sname);
	SetPVarString(playerid, "ItemName", sname);
	SetPVarInt(playerid, "ItemID", itemid);
	SetPVarInt(playerid, "ItemBox", 1337);
	convert_encoding(sname);
	TextDrawSetString(ItemBox[playerid][3], sname);
	if(PlacedItems[itemid][pContainer] != -1)
	{
		SetPVarInt(playerid, "ItemContainer", PlacedItems[itemid][pContainer]);
		mysql_format(db, string, 128, "SELECT containerSize FROM containers WHERE containerID = '%i';", PlacedItems[itemid][pContainer]);
		mysql_function_query(db, string, true, "GetContainerLoadVolume", "i", ivolume);
		format(sname, 24, "Volume: %iml", ivolume);
		TextDrawSetString(ItemBox[playerid][4], sname);
		SetPVarInt(playerid, "ItemVolume", ivolume);
		mysql_format(db, string, 128, "SELECT containerWeight FROM containers WHERE containerID = '%i';", PlacedItems[itemid][pContainer]);
		mysql_function_query(db, string, true, "GetContainerLoadWeight", "i", iweight);
		format(sname, 24, "Peso: %ig", iweight);
		TextDrawSetString(ItemBox[playerid][5], sname);
		SetPVarInt(playerid, "ItemWeight", iweight);
	}
	else
	{
		SetPVarInt(playerid, "ItemContainer", -1);
		mysql_format(db, string, 128, "SELECT itemVolume FROM items WHERE itemID = '%i';", PlacedItems[itemid][pID]);
		mysql_function_query(db, string, true, "GetItemVolume", "i", ivolume);
		format(sname, 24, "Volume: %iml", ivolume);
		TextDrawSetString(ItemBox[playerid][4], sname);
		SetPVarInt(playerid, "ItemVolume", ivolume);
		mysql_format(db, string, 128, "SELECT itemWeight FROM items WHERE itemID = '%i';", PlacedItems[itemid][pID]);
		mysql_function_query(db, string, true, "GetItemWeight", "i", iweight);
		format(sname, 24, "Peso: %ig", iweight);
		TextDrawSetString(ItemBox[playerid][5], sname);
		SetPVarInt(playerid, "ItemWeight", iweight);
	}
	mysql_format(db, string, 128, "SELECT itemModel FROM items WHERE itemID = '%i';", PlacedItems[itemid][pID]);
	mysql_function_query(db, string, true, "GetItemModel", "i", imodel);
	SetPVarInt(playerid, "ItemModel", imodel);
	TextDrawSetPreviewModel(ItemBox[i][2], imodel);
	for(new i = 0; i < 8; i++) TextDrawShowForPlayer(playerid, ItemBox[playerid][i]);
	return true;
}

//###################################################################################################

/***
   * GetItemID(&itemid);
   * Utilizada para retornar um item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetItemID(itemid)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1) 
	{
		cache_get_row(0, 0, result);
		itemid = strval(result);
	}
	else itemid = -1;
	return;
}

/***
   * GetItemName(&itemname[]);
   * Utilizada para retornar um item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetItemName(itemnamex[])
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1) 
	{
		cache_get_row(0, 0, result);
		format(itemnamex, 24, "%s", result);
	}
	else format(itemnamex, 24, "Nenhum");
	return;
}

/***
   * GetItemWeight(&itemweight);
   * Utilizada para retornar o peso de um item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetItemWeight(itemweight)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1) 
	{
		cache_get_row(0, 0, result);
		itemweight = strval(result);
	}
	else itemweight = 0;
	return;
}

/***
   * GetItemModel(&itemmodel);
   * Utilizada para retornar o peso de um item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetItemModel(itemmodel)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1) 
	{
		cache_get_row(0, 0, result);
		itemmodel = strval(result);
	}
	else itemmodel = -1;
	return;
}

/***
   * GetItemVolume(&itemvolume);
   * Utilizada para retornar o volume de um item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetItemVolume(itemvolume)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1) 
	{
		cache_get_row(0, 0, result);
		itemvolume = strval(result);
	}
	else itemvolume = 0;
	return;
}

/***
   * GetContainerSize(size);
   * Utilizada para retornar o tamanho de um container;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetContainerSize(size)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1) 
	{
		cache_get_row(0, 0, result);
		size = strval(result);
	}
	else size = 0;
	return;
}

/***
   * GetContainerLoadVolume(&itemvolume);
   * Utilizada para retornar o volume de um container;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetContainerLoadVolume(load)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1) 
	{
		cache_get_row(0, 0, result);
		load = strval(result);
	}
	else load = 0;
	return;
}

/***
   * GetContainerLoadWeight(&itemvolume);
   * Utilizada para retornar o peso de um container;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetContainerLoadWeight(load)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1) 
	{
		cache_get_row(0, 0, result);
		load = strval(result);
	}
	else load = 0;
	return;
}

/***
   * GetContainerWeight(weight);
   * Utilizada para retornar o peso de um container;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetContainerWeight(weight)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1) 
	{
		cache_get_row(0, 0, result);
		weight = strval(result);
	}
	else weight = 0;
	return;
}

/***
   * GetPlacedItemID(placeditem);
   * Utilizada para retornar o volume de um container;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetPlacedItemID(placeditem)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows >= 1) 
	{
		cache_get_row(0, 0, result);
		placeditem = strval(result);
	}
	else placeditem = -1;
	return;
}

public LoadPlacedItems()
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	for(new i = 0; i < rows; i++)
	{
		cache_get_row(i, 0, result);
		PlacedItems[i][pID] = strval(result);
		cache_get_row(i, 1, result);
		PlacedItems[i][pContainer] = strval(result);
		cache_get_row(i, 2, result);
		PlacedItems[i][pItem] = strval(result);
		cache_get_row(i, 3, result);
		PlacedItems[i][pPosX] = floatstr(result);
		cache_get_row(i, 4, result);
		PlacedItems[i][pPosY] = floatstr(result);
		cache_get_row(i, 5, result);
		PlacedItems[i][pPosZ] = floatstr(result);
		cache_get_row(i, 6, result);
		PlacedItems[i][pInt] = strval(result);
		cache_get_row(i, 7, result);
		PlacedItems[i][pVW] = strval(result);
		Iter_Add(ItemsPlaced, PlacedItems[i][pID]);
	}
	return;
}

public IsItemContainer(itemid)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows >= 1) 
	{
		cache_get_row(0, 0, result);
		itemid = strval(result);
	}
	else itemid = -1;
	return;
}