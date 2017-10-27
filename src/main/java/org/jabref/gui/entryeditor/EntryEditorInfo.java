package org.jabref.gui.entryeditor;

import org.jabref.gui.BasePanel;
import org.jabref.gui.autocompleter.SuggestionProviders;
import org.jabref.logic.pdf.FileAnnotationCache;
import org.jabref.model.database.BibDatabase;
import org.jabref.model.database.BibDatabaseContext;
import org.jabref.model.database.BibDatabaseMode;
import org.jabref.model.entry.BibEntry;
import org.jabref.model.entry.EntryType;

/**
 * This interface is implemented by {@link EntryEditor} and provides all instances of {@link EntryEditorTab} with the
 * necessary information to display and work with the currently selected {@link BibEntry}.
 */
public interface EntryEditorInfo {


    BibEntry getEntry();

    EntryType getEntryType();

    BasePanel getBasePanel();

    FileAnnotationCache getFileAnnotationCache();

    BibDatabase getDatabase();

    BibDatabaseMode getDatabaseMode();

    BibDatabaseContext getDatabaseContext();

    SuggestionProviders getSuggestionProviders();

    void updateEntryEditor();

}
