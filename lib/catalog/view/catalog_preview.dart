/// OpenUI source that renders a representative example for [componentName].
///
/// Each snippet must assign the root element to `root` (the renderer default).
String catalogPreviewSource(String componentName) {
  return switch (componentName) {
    'Stack' =>
      '''
root = Stack(children: [
  TextContent(text: "First item"),
  TextContent(text: "Second item")
])
''',
    'Card' =>
      '''
root = Card(children: [
  CardHeader(title: "Card title", subtitle: "Optional subtitle"),
  TextContent(text: "Body copy inside the card.")
])
''',
    'CardHeader' =>
      '''
root = CardHeader(title: "Section title", subtitle: "Supporting detail")
''',
    'Separator' => 'root = Separator()\n',
    'Callout' =>
      '''
root = Callout(text: "This is an informational callout.", variant: "info")
''',
    'TextContent' =>
      '''
root = TextContent(text: "Styled paragraph text for the catalog preview.")
''',
    'MarkDownRenderer' =>
      'root = MarkDownRenderer(source: "## Heading\\n\\n**Bold** and *italic* text.")\n',
    'Image' =>
      '''
root = Image(
  src: "https://picsum.photos/seed/openui-catalog/320/180",
  alt: "Sample landscape"
)
''',
    'Input' =>
      r'''
$field = "Hello"
root = Input(name: "field", value: $field, placeholder: "Type here…")
''',
    'Select' =>
      r'''
$status = "Open"
root = Select(
  options: ["Open", "In progress", "Done"],
  value: $status
)
''',
    'Button' => 'root = Button(label: "Continue")\n',
    'Table' =>
      '''
root = Table(
  columns: [{name: "name", label: "Name"}, {name: "value", label: "Value"}],
  rows: [
    {name: "Alice", value: "1"},
    {name: "Bob", value: "2"}
  ]
)
''',
    'Col' => 'root = Col(name: "id", label: "ID")\n',
    'Tabs' =>
      '''
root = Tabs(children: [
  TabItem(label: "Overview", content: TextContent(text: "Overview tab.")),
  TabItem(label: "Details", content: TextContent(text: "Details tab."))
])
''',
    'TabItem' =>
      '''
root = TabItem(label: "Tab", content: TextContent(text: "Tab body."))
''',
    'BarChart' =>
      '''
root = BarChart(
  series: [
    {name: "Revenue", values: [12, 19, 15, 22]},
    {name: "Cost", values: [8, 11, 9, 14]}
  ],
  labels: ["Q1", "Q2", "Q3", "Q4"]
)
''',
    'LineChart' =>
      '''
root = LineChart(
  series: [{name: "Signal", values: [1, 3, 2, 4, 3]}],
  labels: ["Mon", "Tue", "Wed", "Thu", "Fri"]
)
''',
    _ => 'root = TextContent(text: "No preview defined.")\n',
  };
}
