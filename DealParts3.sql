# Adding foreign keys into the tables
USE deals;
# Add foreign key TypeCode to DealTypes table
ALTER TABLE DealTypes
  ADD FOREIGN KEY (TypeCode)
    REFERENCES TypeCodes  (TypeCode);
#Add foreign key DealID to DealTypes tabe
ALTER TABLE DealTypes
  ADD FOREIGN KEY (DealID)
    REFERENCES Deals  (DealID);
#Add foreign key DealID to DealParts
ALTER TABLE DealParts
  ADD FOREIGN KEY (DealID)
    REFERENCES Deals  (DealID);
#Add foreign key DealID to Players
ALTER TABLE Players
  ADD FOREIGN KEY (DealID)
    REFERENCES Deals  (DealID);
#Add foreign key CompanyID to Players
ALTER TABLE Players
  ADD FOREIGN KEY (CompanyID)
    REFERENCES Companies  (CompanyID);
#Add foreign key RoleCode to Players
ALTER TABLE Players
  ADD FOREIGN KEY (RoleCode)
    REFERENCES RoleCodes  (RoleCode);
#Add foreign key RoleCode to Players
ALTER TABLE PlayerSupports
  ADD FOREIGN KEY (SupportCodeID)
    REFERENCES SupportCodes (SupportCodeID);
#Add foreign key RoleCode to Players
ALTER TABLE PlayerSupports
  ADD FOREIGN KEY (SupportCodeID)
    REFERENCES SupportCodes (SupportCodeID);
#Add foreign key RoleCode to Players
ALTER TABLE PlayerSupports
  ADD FOREIGN KEY (FirmID)
    REFERENCES Firms (FirmID);