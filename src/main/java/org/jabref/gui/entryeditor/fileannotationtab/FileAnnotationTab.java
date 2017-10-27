package org.jabref.gui.entryeditor.fileannotationtab;

import javafx.scene.control.Tooltip;

import org.jabref.gui.entryeditor.EntryEditorInfo;
import org.jabref.gui.entryeditor.EntryEditorTab;
import org.jabref.logic.l10n.Localization;
import org.jabref.logic.pdf.FileAnnotationCache;
import org.jabref.model.entry.BibEntry;
import org.jabref.model.entry.FieldName;

public class FileAnnotationTab extends EntryEditorTab {

    private EntryEditorInfo info;
    private final FileAnnotationCache fileAnnotationCache;

    public FileAnnotationTab(EntryEditorInfo editorInfo) {
        info = editorInfo;
        fileAnnotationCache = info.getFileAnnotationCache();
        setText(Localization.lang("File annotations"));
        setTooltip(new Tooltip(Localization.lang("Show file annotations")));
    }

    @Override
    public boolean shouldShow() {
        BibEntry entry = info.getEntry();
        return entry != null && entry.getField(FieldName.FILE).isPresent();
    }

    @Override
    protected void bindToEntry() {
        setContent(new FileAnnotationTabView(info.getEntry(), fileAnnotationCache).getView());
    }
}
