export type SubEvent = 0 | 1 | 2;

export interface ScoreNode {
    formId: string;
    eventId: string;
    position: number;
    calculatedPoints?: number;
}

export interface Event {
    subEvent: SubEvent;
    yearGroup: number;
}

export interface PointAlloc {
    subEvent: SubEvent;
    position: number;
    points: number;
}
