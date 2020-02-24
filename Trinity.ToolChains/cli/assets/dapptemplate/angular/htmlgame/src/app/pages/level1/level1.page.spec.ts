import { async, ComponentFixture, TestBed } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';

import { Level1Page } from './level1.page';

describe('Level1Page', () => {
  let component: Level1Page;
  let fixture: ComponentFixture<Level1Page>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ Level1Page ],
      imports: [IonicModule.forRoot()]
    }).compileComponents();

    fixture = TestBed.createComponent(Level1Page);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
