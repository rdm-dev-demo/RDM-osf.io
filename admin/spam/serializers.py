from website.project.model import User


def serialize_comment(comment, full=False):
    reports = serialize_reports(comment.reports)

    return {
        'id': comment._id,
        'author': User.load(comment.user._id),
        'author_id': comment.user._id,
        'date_created': comment.date_created,
        'date_modified': comment.date_modified,
        'content': comment.content,
        'has_children': bool(getattr(comment, 'commented', [])),
        'modified': comment.modified,
        'is_deleted': comment.is_deleted,
        'spam_status': comment.spam_status,
        'reports': reports,
        'node': comment.node,
        'category': reports[0]['category'],
    }


def serialize_reports(reports):
    return [
        serialize_report(user, report)
        for user, report in reports.iteritems()
    ]


def serialize_report(user, report):
    return {
        'reporter': User.load(user),
        'category': report.get('category', None),
        'reason': report.get('text', None),
    }
