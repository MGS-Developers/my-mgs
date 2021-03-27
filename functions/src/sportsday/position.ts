import {groupBy, flatten} from 'lodash';

export function runCompetition<T>(
    unranked: T[],
    getValue: (e: T) => number,
    setRank: (e: T, rank: number) => void,
): T[] {
    const sameValuesGrouped = groupBy([...unranked], getValue);
    const sortedKeys = Object.keys(sameValuesGrouped).sort((a, b) => {
        return parseInt(b) - parseInt(a);
    });

    const sortedGroupedItems: T[][] = [];
    sortedKeys.forEach(key => {
        sortedGroupedItems.push(sameValuesGrouped[key]);
    });

    sortedGroupedItems.forEach((items, index) => {
        const rank = index + 1;

        items.forEach((item) => {
            setRank(item, rank);
        });
    });

    return flatten(sortedGroupedItems);
}
