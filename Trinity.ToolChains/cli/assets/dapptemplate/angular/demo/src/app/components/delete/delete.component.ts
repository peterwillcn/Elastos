import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { NavParams, PopoverController } from '@ionic/angular';
import { DAppService } from 'src/app/services/dapp.service';

@Component({
  selector: 'app-delete',
  templateUrl: './delete.component.html',
  styleUrls: ['./delete.component.scss'],
})
export class DeleteComponent implements OnInit {

  @Output() cancelEvent = new EventEmitter<boolean>();

  constructor(
    private navParams: NavParams,
    private popover: PopoverController,
    public dAppService: DAppService
  ) { }

  ngOnInit() {
  }

  cancel() {
    this.popover.dismiss();
  }

}
