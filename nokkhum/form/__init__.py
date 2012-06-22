from wtforms.form import Form
from markupsafe import Markup


class AbstactForm(Form):
    format = '<div class="error">${error}</div>'
    def get_error(self, name):
        if len(self.errors) == 0:
            return ''
        elif not name in self.errors:
            return ''
        elif len(self.errors[name]) == 0:
            return ''
        elif len(self.errors[name]) == 1:
            return Markup(self.format.replace("${error}", self.errors[name][0]))
        else:
            message = ""
            for error in self.errors[name]:
                message += (error + ", ")
            return Markup(self.format.replace("${error}", message))