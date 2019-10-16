import { Component, OnInit, Input } from '@angular/core';

declare let appService: any;

@Component({
    selector: 'header-bar',
    templateUrl: './header-bar.component.html',
    styleUrls: ['./header-bar.component.scss'],
})
export class HeaderBarComponent implements OnInit {
    public back_touched = false;
    public _title: string = '';

    @Input()
    set title(title: string) {
        this._title = title;
    }

    constructor() { }

    ngOnInit() { }

    launcher() {
        appService.launcher();
    }

    close() {
        appService.close();
    }
}
