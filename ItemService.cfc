// ItemService.cfc
component {
    function getItems() {
        return queryExecute("SELECT id, name, position FROM items ORDER BY position");
    }

    function updateItemPosition(required numeric id, required numeric newPosition) {
        var currentPosition = queryExecute("SELECT position FROM items WHERE id = :id", {id: id}).position[1];
        
        if (newPosition < currentPosition) {
            queryExecute("
                UPDATE items 
                SET position = position + 1 
                WHERE position >= :newPosition AND position < :currentPosition
            ", {newPosition: newPosition, currentPosition: currentPosition});
        } else if (newPosition > currentPosition) {
            queryExecute("
                UPDATE items 
                SET position = position - 1 
                WHERE position <= :newPosition AND position > :currentPosition
            ", {newPosition: newPosition, currentPosition: currentPosition});
        }

        queryExecute("UPDATE items SET position = :newPosition WHERE id = :id", {id: id, newPosition: newPosition});
    }
}