import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { Level4Page } from './level4.page';

describe('Level4Page', () => {
  let component: Level4Page;
  let fixture: ComponentFixture<Level4Page>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ Level4Page ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Level4Page);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
