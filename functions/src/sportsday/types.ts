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

export interface EventGroup {
    id: string;
    name: string;
    subEventCount: number;
    scoreSpecId: string;
}

export interface PointAlloc {
    subEvent: SubEvent;
    position: number;
    points: number;
}

export interface FormPoints {
    total: number;
    yearPosition?: number;
    schoolPosition?: number;
}

export interface Form {
    points?: FormPoints;
    yearGroup: number;
    id: string;
}

export interface FormWithPoints extends Form {
    points: FormPoints;
}
