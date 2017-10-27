package org.jabref.gui.entryeditor;

import java.util.List;

import org.jabref.gui.IconTheme;
import org.jabref.gui.IconTheme.JabRefIcon;
import org.jabref.gui.autocompleter.SuggestionProviders;
import org.jabref.model.database.BibDatabaseContext;
import org.jabref.model.entry.BibEntry;
import org.jabref.model.entry.EntryType;

public class UserDefinedFieldsTab extends FieldsEditorTab {
    private final List<String> fields;

    public UserDefinedFieldsTab(String name, List<String> fields, EntryEditorInfo info) {
        super(info);
        this.fields = fields;
        setText(name);
        setGraphic(JabRefIcon.OPTIONAL.getGraphicNode());
    }

    @Override
    protected List<String> determineFieldsToShow(EntryType entryType) {
        return fields;
    }
}
