class CoreIcons {
  final String? name;
  final String? path;

  const CoreIcons({this.name, this.path});

  static CoreIcons getIcon(String? fileExtension) {
    fileExtension = fileExtension?.toLowerCase();
    switch (fileExtension) {
      case 'doc':
      case 'docx':
        return worddocument;
      case 'pdf':
      case 'application/pdf':
        return pdf;
      case 'xls':
      case 'xlsx':
        return exceldocument;
      case 'ppt':
      case 'pptx':
        return powerpoint;
      case 'jpg':
      case 'gif':
      case 'png':
      case 'image/jpeg':
      case 'image/png':
      case 'image/gif':
        return image;
      case 'video/mp4':
        return video;
      default:
        return file;
    }
  }

  static CoreIcons getIconForName(String? iconName) {
    if (iconName == null) return CoreIcons.modules;

    iconName = iconName.toLowerCase();

    return coreIcons.firstWhere(
        (element) => element.name!.toLowerCase() == iconName,
        orElse: () => CoreIcons.modules);
  }

  static CoreIcons getIconForEvent(String subject) {
    if (subject.toLowerCase().contains("parents") &&
        subject.toLowerCase().contains("evening")) {
      return CoreIcons.parentsevening;
    }
    if (subject.toLowerCase().contains("lunch")) {
      return CoreIcons.lunch;
    }
    if (subject.toLowerCase().contains("break")) {
      return CoreIcons.breaks;
    }
    if (subject.toLowerCase().contains("paternity")) {
      return CoreIcons.baby;
    }
    if (subject.toLowerCase().contains("maternity")) {
      return CoreIcons.baby;
    }
    if (subject.toLowerCase().contains("teams lesson")) {
      return CoreIcons.teamslesson;
    }
    if (subject.toLowerCase().contains("wfh")) {
      return CoreIcons.wfh;
    }
    if (subject.toLowerCase().contains("working from home")) {
      return CoreIcons.wfh;
    }
    if (subject.toLowerCase().contains("remote")) {
      return CoreIcons.wfh;
    }
    return CoreIcons.event;
  }

  static List<CoreIcons> coreIcons = [
    aboutme,
    accidentplus,
    accidentbook,
    accidentreporting,
    add,
    adddate,
    adddocument,
    addlink,
    agile,
    agilereport,
    ai,
    analytics,
    api,
    apps,
    archive,
    attendance,
    award,
    baby,
    barcode,
    billing,
    bin,
    book,
    bookreading,
    books,
    bookmarkhome,
    brain,
    breaks,
    caduceus,
    calendar,
    cat,
    catalyst,
    chat,
    chatcall,
    checklist,
    chevrondown,
    chevronleft,
    chevronright,
    chevronup,
    choice,
    classsync,
    classroom,
    clear,
    clearbookmark,
    clipboard,
    cloudsync,
    collapse,
    comment,
    commercial,
    contactcard,
    copy,
    cpoms,
    creategroup,
    createpage,
    critical,
    cross,
    dash,
    dashboard,
    dataentry,
    dateSettings,
    delete,
    diamond,
    dice,
    document,
    dog,
    doubleleft,
    doubleright,
    download,
    downloadxls,
    duplicate,
    edit,
    editdetails,
    editreport,
    elearning,
    email,
    emailsignature,
    empty,
    epipen,
    error,
    event,
    eventTime,
    eventSignup,
    exam,
    examresults,
    exceldocument,
    expand,
    experiment,
    external,
    eye,
    favouriteEmpty,
    favouriteFilled,
    file,
    filter,
    finish,
    fire,
    firefly,
    folder,
    form,
    freeperiods,
    goal,
    guitarist,
    health,
    heartplus,
    heartwithdots,
    heartwithpulse,
    heartwithtick,
    help,
    helpdesk,
    hidemenu,
    house,
    hourglass,
    idcard,
    image,
    important,
    importantbook,
    improvement,
    inhaler,
    inprogress,
    info,
    infoRound,
    instruments,
    internal,
    keyboard,
    leaverequest,
    lecture,
    link,
    linkedin,
    list,
    lock,
    lowimportance,
    lunch,
    mailings,
    map,
    masquerade,
    medal,
    medical,
    medicalbed,
    medicalbook,
    medicallaptop,
    medication,
    meeting,
    meetingtime,
    mentor,
    modules,
    more,
    morefilled,
    musicbook,
    musicconductor,
    news,
    notfound,
    notification,
    notify,
    noticeboard,
    notes,
    number,
    office365,
    okay,
    onedrive,
    open,
    otp,
    paint,
    pallet,
    parent,
    parentsevening,
    paris,
    people,
    permissions,
    pdf,
    person,
    pharmacy,
    plane,
    play,
    plus,
    podium,
    powerpoint,
    presentation,
    print,
    protect,
    pushnotification,
    racinglap,
    rainbow,
    record,
    refresh,
    reports,
    reportgraph,
    reportviewer,
    reply,
    restore,
    review,
    richtext,
    ringingbell,
    realtime,
    salary,
    sanction,
    save,
    saveall,
    schedule,
    school,
    search,
    searchbar,
    searchbook,
    searchlist,
    secure,
    secureuser,
    sendmessages,
    sendtoprinter,
    settings,
    shapes,
    share,
    showdates,
    showmenu,
    spaces,
    specialdate,
    specialdates,
    spellcheck,
    staffmember,
    starempty,
    starfilled,
    stark,
    start,
    stopimpersonating,
    stopmasquerading,
    student,
    students,
    studyleave,
    success,
    summarylist,
    swap,
    systemadmin,
    teamwork,
    teams,
    teamslesson,
    test,
    testtube,
    tick,
    tickcircled,
    tickcross,
    ticketpurchase,
    timeMachine,
    todolist,
    todoist,
    tools,
    torin,
    transactions,
    transfer,
    treatment,
    unavailable,
    undo,
    update,
    upload,
    upgrade,
    user,
    usersettings,
    usertick,
    vectare,
    vip,
    video,
    view,
    viewfile,
    warning,
    web,
    wfh,
    windows,
    worddocument,
    workstation,
    world,
  ];

  static const CoreIcons aboutme =
      CoreIcons(name: 'aboutme', path: 'assets/icons/about_me.svg');
  static const CoreIcons accidentplus =
      CoreIcons(name: 'accidentplus', path: 'assets/icons/accidentplus.svg');
  static const CoreIcons accidentbook =
      CoreIcons(name: 'accidentbook', path: 'assets/icons/accidentbook.svg');
  static const CoreIcons accidentreporting = CoreIcons(
      name: 'accidentreporting', path: 'assets/icons/accidentreporting.svg');
  static const CoreIcons add =
      CoreIcons(name: 'add', path: 'assets/icons/add.svg');
  static const CoreIcons adddate =
      CoreIcons(name: 'adddate', path: 'assets/icons/adddate.svg');
  static const CoreIcons adddocument =
      CoreIcons(name: 'adddocument', path: 'assets/icons/adddocument.svg');
  static const CoreIcons addlink =
      CoreIcons(name: 'addlink', path: 'assets/icons/addlink.svg');
  static const CoreIcons agile =
      CoreIcons(name: 'agile', path: 'assets/icons/agile.svg');
  static const CoreIcons agilereport =
      CoreIcons(name: 'agilereport', path: 'assets/icons/agilereport.svg');
  static const CoreIcons ai =
      CoreIcons(name: 'ai', path: 'assets/icons/ai.svg');
  static const CoreIcons analytics =
      CoreIcons(name: 'analytics', path: 'assets/icons/analytics.svg');
  static const CoreIcons api =
      CoreIcons(name: 'api', path: 'assets/icons/api.svg');
  static const CoreIcons apps =
      CoreIcons(name: 'apps', path: 'assets/icons/apps.svg');
  static const CoreIcons archive =
      CoreIcons(name: 'archive', path: 'assets/icons/archive.svg');
  static const CoreIcons attendance =
      CoreIcons(name: 'attendance', path: 'assets/icons/attendance.svg');
  static const CoreIcons award =
      CoreIcons(name: 'award', path: 'assets/icons/award.svg');
  static const CoreIcons baby =
      CoreIcons(name: 'baby', path: 'assets/icons/baby.svg');
  static const CoreIcons barcode =
      CoreIcons(name: 'barcode', path: 'assets/icons/barcode.svg');
  static const CoreIcons billing =
      CoreIcons(name: 'billing', path: 'assets/icons/billing.svg');
  static const CoreIcons bin =
      CoreIcons(name: 'bin', path: 'assets/icons/bin.svg');
  static const CoreIcons book =
      CoreIcons(name: 'book', path: 'assets/icons/book.svg');
  static const CoreIcons bookreading =
      CoreIcons(name: 'bookreading', path: 'assets/icons/bookreading.svg');
  static const CoreIcons books =
      CoreIcons(name: 'books', path: 'assets/icons/books.svg');
  static const CoreIcons bookmarkhome =
      CoreIcons(name: 'bookmarkhome', path: 'assets/icons/bookmarkhome.svg');
  static const CoreIcons brain =
      CoreIcons(name: 'brain', path: 'assets/icons/brain.svg');
  static const CoreIcons breaks =
      CoreIcons(name: 'breaks', path: 'assets/icons/breaks.svg');
  static const CoreIcons caduceus =
      CoreIcons(name: 'caduceus', path: 'assets/icons/caduceus.svg');
  static const CoreIcons calendar =
      CoreIcons(name: 'calendar', path: 'assets/icons/calendar.svg');
  static const CoreIcons cat =
      CoreIcons(name: 'cat', path: 'assets/icons/cat.svg');
  static const CoreIcons catalyst =
      CoreIcons(name: 'catalyst', path: 'assets/icons/catalyst.svg');
  static const CoreIcons chat =
      CoreIcons(name: 'chat', path: 'assets/icons/chat.svg');
  static const CoreIcons chatcall =
      CoreIcons(name: 'chatcall', path: 'assets/icons/chatcall.svg');
  static const CoreIcons checklist =
      CoreIcons(name: 'checklist', path: 'assets/icons/checklist.svg');
  static const CoreIcons chevrondown =
      CoreIcons(name: 'chevrondown', path: 'assets/icons/chevrondown.svg');
  static const CoreIcons chevronleft =
      CoreIcons(name: 'chevronleft', path: 'assets/icons/chevronleft.svg');
  static const CoreIcons chevronright =
      CoreIcons(name: 'chevronright', path: 'assets/icons/chevronright.svg');
  static const CoreIcons chevronup =
      CoreIcons(name: 'chevronup', path: 'assets/icons/chevronup.svg');
  static const CoreIcons choice =
      CoreIcons(name: 'choice', path: 'assets/icons/choice.svg');
  static const CoreIcons classsync =
      CoreIcons(name: 'classsync', path: 'assets/icons/classsync.svg');
  static const CoreIcons classroom =
      CoreIcons(name: 'classroom', path: 'assets/icons/classroom.svg');
  static const CoreIcons clear =
      CoreIcons(name: 'clear', path: 'assets/icons/clear.svg');
  static const CoreIcons clearbookmark =
      CoreIcons(name: 'clearbookmark', path: 'assets/icons/clearbookmark.svg');
  static const CoreIcons clipboard =
      CoreIcons(name: 'clipboard', path: 'assets/icons/clipboard.svg');
  static const CoreIcons cloudsync =
      CoreIcons(name: 'cloudsync', path: 'assets/icons/cloudsync.svg');
  static const CoreIcons collapse =
      CoreIcons(name: 'collapse', path: 'assets/icons/collapse.svg');
  static const CoreIcons comment =
      CoreIcons(name: 'comment', path: 'assets/icons/comment.svg');
  static const CoreIcons commercial =
      CoreIcons(name: 'commercial', path: 'assets/icons/commercial.svg');
  static const CoreIcons contactcard =
      CoreIcons(name: 'contactcard', path: 'assets/icons/contactcard.svg');
  static const CoreIcons copy =
      CoreIcons(name: 'copy', path: 'assets/icons/copy.svg');
  static const CoreIcons cpoms =
      CoreIcons(name: 'cpoms', path: 'assets/icons/cpoms.svg');
  static const CoreIcons creategroup =
      CoreIcons(name: 'creategroup', path: 'assets/icons/creategroup.svg');
  static const CoreIcons createpage =
      CoreIcons(name: 'createpage', path: 'assets/icons/createpage.svg');
  static const CoreIcons critical =
      CoreIcons(name: 'critical', path: 'assets/icons/critical.svg');
  static const CoreIcons cross =
      CoreIcons(name: 'cross', path: 'assets/icons/cross.svg');
  static const CoreIcons dash =
      CoreIcons(name: 'dash', path: 'assets/icons/dash.svg');
  static const CoreIcons dashboard =
      CoreIcons(name: 'dashboard', path: 'assets/icons/dashboard.svg');
  static const CoreIcons dataentry =
      CoreIcons(name: 'dataentry', path: 'assets/icons/dataentry.svg');
  static const CoreIcons dateSettings =
      CoreIcons(name: 'dateSettings', path: 'assets/icons/datesettings.svg');
  static const CoreIcons delete =
      CoreIcons(name: 'delete', path: 'assets/icons/delete.svg');
  static const CoreIcons diamond =
      CoreIcons(name: 'diamond', path: 'assets/icons/diamond.svg');
  static const CoreIcons dice =
      CoreIcons(name: 'dice', path: 'assets/icons/dice.svg');
  static const CoreIcons document =
      CoreIcons(name: 'document', path: 'assets/icons/document.svg');
  static const CoreIcons dog =
      CoreIcons(name: 'dog', path: 'assets/icons/dog.svg');
  static const CoreIcons doubleleft =
      CoreIcons(name: 'doubleleft', path: 'assets/icons/doubleleft.svg');
  static const CoreIcons doubleright =
      CoreIcons(name: 'doubleright', path: 'assets/icons/doubleright.svg');
  static const CoreIcons download =
      CoreIcons(name: 'download', path: 'assets/icons/download.svg');
  static const CoreIcons downloadxls =
      CoreIcons(name: 'downloadxls', path: 'assets/icons/downloadxls.svg');
  static const CoreIcons duplicate =
      CoreIcons(name: 'duplicate', path: 'assets/icons/duplicate.svg');
  static const CoreIcons edit =
      CoreIcons(name: 'edit', path: 'assets/icons/edit.svg');
  static const CoreIcons editdetails =
      CoreIcons(name: 'editdetails', path: 'assets/icons/editdetails.svg');
  static const CoreIcons editreport =
      CoreIcons(name: 'editreport', path: 'assets/icons/editreport.svg');
  static const CoreIcons elearning =
      CoreIcons(name: 'elearning', path: 'assets/icons/elearning.svg');
  static const CoreIcons email =
      CoreIcons(name: 'email', path: 'assets/icons/email.svg');
  static const CoreIcons emailsignature = CoreIcons(
      name: 'emailsignature', path: 'assets/icons/emailsignature.svg');
  static const CoreIcons empty =
      CoreIcons(name: 'empty', path: 'assets/icons/empty.svg');
  static const CoreIcons epipen =
      CoreIcons(name: 'epipen', path: 'assets/icons/epipen.svg');
  static const CoreIcons error =
      CoreIcons(name: 'error', path: 'assets/icons/error.svg');
  static const CoreIcons event =
      CoreIcons(name: 'event', path: 'assets/icons/event.svg');
  static const CoreIcons eventTime =
      CoreIcons(name: 'eventTime', path: 'assets/icons/event_time.svg');
  static const CoreIcons eventSignup =
      CoreIcons(name: 'eventSignup', path: 'assets/icons/eventsignup.svg');
  static const CoreIcons exam =
      CoreIcons(name: 'exam', path: 'assets/icons/exam.svg');
  static const CoreIcons examresults =
      CoreIcons(name: 'examresults', path: 'assets/icons/examresults.svg');
  static const CoreIcons exceldocument =
      CoreIcons(name: 'exceldocument', path: 'assets/icons/exceldocument.svg');
  static const CoreIcons expand =
      CoreIcons(name: 'expand', path: 'assets/icons/expand.svg');
  static const CoreIcons experiment =
      CoreIcons(name: 'experiment', path: 'assets/icons/experiment.svg');
  static const CoreIcons external =
      CoreIcons(name: 'external', path: 'assets/icons/external.svg');
  static const CoreIcons eye =
      CoreIcons(name: 'eye', path: 'assets/icons/eye.svg');
  static const CoreIcons favouriteEmpty =
      CoreIcons(name: 'favouriteEmpty', path: 'assets/icons/favempty.svg');
  static const CoreIcons favouriteFilled =
      CoreIcons(name: 'favouriteFilled', path: 'assets/icons/favfilled.svg');
  static const CoreIcons file =
      CoreIcons(name: 'file', path: 'assets/icons/file.svg');
  static const CoreIcons filter =
      CoreIcons(name: 'filter', path: 'assets/icons/filter.svg');
  static const CoreIcons finish =
      CoreIcons(name: 'finish', path: 'assets/icons/finish.svg');
  static const CoreIcons fire =
      CoreIcons(name: 'fire', path: 'assets/icons/fire.svg');
  static const CoreIcons firefly =
      CoreIcons(name: 'firefly', path: 'assets/icons/firefly.svg');
  static const CoreIcons folder =
      CoreIcons(name: 'folder', path: 'assets/icons/folder.svg');
  static const CoreIcons form =
      CoreIcons(name: 'form', path: 'assets/icons/form.svg');
  static const CoreIcons freeperiods =
      CoreIcons(name: 'freeperiods', path: 'assets/icons/freeperiods.svg');
  static const CoreIcons goal =
      CoreIcons(name: 'goal', path: 'assets/icons/goal.svg');
  static const CoreIcons guitarist =
      CoreIcons(name: 'guitarist', path: 'assets/icons/guitarist.svg');
  static const CoreIcons health =
      CoreIcons(name: 'health', path: 'assets/icons/health.svg');
  static const CoreIcons heartplus =
      CoreIcons(name: 'heartplus', path: 'assets/icons/heartplus.svg');
  static const CoreIcons heartwithdots =
      CoreIcons(name: 'heartwithdots', path: 'assets/icons/heartwithdots.svg');
  static const CoreIcons heartwithpulse = CoreIcons(
      name: 'heartwithpulse', path: 'assets/icons/heartwithpulse.svg');
  static const CoreIcons heartwithtick =
      CoreIcons(name: 'heartwithtick', path: 'assets/icons/heartwithtick.svg');
  static const CoreIcons help =
      CoreIcons(name: 'help', path: 'assets/icons/help.svg');
  static const CoreIcons helpdesk =
      CoreIcons(name: 'helpdesk', path: 'assets/icons/helpdesk.svg');
  static const CoreIcons hidemenu =
      CoreIcons(name: 'hidemenu', path: 'assets/icons/hidemenu.svg');
  static const CoreIcons house =
      CoreIcons(name: 'house', path: 'assets/icons/house.svg');
  static const CoreIcons hourglass =
      CoreIcons(name: 'houseglass', path: 'assets/icons/hourglass.svg');
  static const CoreIcons idcard =
      CoreIcons(name: 'idcard', path: 'assets/icons/idcard.svg');
  static const CoreIcons image =
      CoreIcons(name: 'image', path: 'assets/icons/image.svg');
  static const CoreIcons important =
      CoreIcons(name: 'important', path: 'assets/icons/important.svg');
  static const CoreIcons importantbook =
      CoreIcons(name: 'importantbook', path: 'assets/icons/importantbook.svg');
  static const CoreIcons improvement =
      CoreIcons(name: 'improvement', path: 'assets/icons/improvement.svg');
  static const CoreIcons inprogress =
      CoreIcons(name: 'inprogress', path: 'assets/icons/inprogress.svg');
  static const CoreIcons info =
      CoreIcons(name: 'info', path: 'assets/icons/info.svg');
  static const CoreIcons infoRound =
      CoreIcons(name: 'infoRound', path: 'assets/icons/info_round.svg');
  static const CoreIcons inhaler =
      CoreIcons(name: 'inhaler', path: 'assets/icons/inhaler.svg');
  static const CoreIcons instruments =
      CoreIcons(name: 'instruments', path: 'assets/icons/instruments.svg');
  static const CoreIcons internal =
      CoreIcons(name: 'internal', path: 'assets/icons/internal.svg');
  static const CoreIcons keyboard =
      CoreIcons(name: 'keyboard', path: 'assets/icons/keyboard.svg');
  static const CoreIcons leaverequest =
      CoreIcons(name: 'leaverequest', path: 'assets/icons/leaverequest.svg');
  static const CoreIcons lecture =
      CoreIcons(name: 'lecture', path: 'assets/icons/lecture.svg');
  static const CoreIcons link =
      CoreIcons(name: 'link', path: 'assets/icons/link.svg');
  static const CoreIcons linkedin =
      CoreIcons(name: 'linkedin', path: 'assets/icons/linkedin.svg');
  static const CoreIcons list =
      CoreIcons(name: 'list', path: 'assets/icons/list.svg');
  static const CoreIcons lock =
      CoreIcons(name: 'lock', path: 'assets/icons/lock.svg');
  static const CoreIcons lowimportance =
      CoreIcons(name: 'lowimportance', path: 'assets/icons/lowimportance.svg');
  static const CoreIcons lunch =
      CoreIcons(name: 'lunch', path: 'assets/icons/lunch.svg');
  static const CoreIcons mailings =
      CoreIcons(name: 'mailings', path: 'assets/icons/mailings.svg');
  static const CoreIcons map =
      CoreIcons(name: 'map', path: 'assets/icons/map.svg');
  static const CoreIcons masquerade =
      CoreIcons(name: 'masquerade', path: 'assets/icons/masquerade.svg');
  static const CoreIcons medal =
      CoreIcons(name: 'medal', path: 'assets/icons/medal.svg');
  static const CoreIcons medical =
      CoreIcons(name: 'medical', path: 'assets/icons/medical.svg');
  static const CoreIcons medicalbed =
      CoreIcons(name: 'medicalbed', path: 'assets/icons/medicalbed.svg');
  static const CoreIcons medicalbook =
      CoreIcons(name: 'medicalbook', path: 'assets/icons/medicalbook.svg');
  static const CoreIcons medicallaptop =
      CoreIcons(name: 'medicallaptop', path: 'assets/icons/medicallaptop.svg');
  static const CoreIcons medication =
      CoreIcons(name: 'medication', path: 'assets/icons/medication.svg');
  static const CoreIcons meeting =
      CoreIcons(name: 'meeting', path: 'assets/icons/meeting.svg');
  static const CoreIcons meetingtime =
      CoreIcons(name: 'meetingtime', path: 'assets/icons/meetingtime.svg');
  static const CoreIcons mentor =
      CoreIcons(name: 'mentor', path: 'assets/icons/mentor.svg');
  static const CoreIcons modules =
      CoreIcons(name: 'modules', path: 'assets/icons/modules.svg');
  static const CoreIcons more =
      CoreIcons(name: 'more', path: 'assets/icons/more.svg');
  static const CoreIcons morefilled =
      CoreIcons(name: 'morefilled', path: 'assets/icons/more_filled.svg');
  static const CoreIcons musicbook =
      CoreIcons(name: 'musicbook', path: 'assets/icons/musicbook.svg');
  static const CoreIcons musicconductor = CoreIcons(
      name: 'musicconductor', path: 'assets/icons/musicconductor.svg');
  static const CoreIcons news =
      CoreIcons(name: 'news', path: 'assets/icons/news.svg');
  static const CoreIcons notfound =
      CoreIcons(name: 'notfound', path: 'assets/icons/notfound.svg');
  static const CoreIcons notification =
      CoreIcons(name: 'notification', path: 'assets/icons/notification.svg');
  static const CoreIcons notify =
      CoreIcons(name: 'notify', path: 'assets/icons/notify.svg');
  static const CoreIcons noticeboard =
      CoreIcons(name: 'noticeboard', path: 'assets/icons/noticeboard.svg');
  static const CoreIcons notes =
      CoreIcons(name: 'notes', path: 'assets/icons/notes.svg');
  static const CoreIcons number =
      CoreIcons(name: 'number', path: 'assets/icons/number.svg');
  static const CoreIcons office365 =
      CoreIcons(name: 'office365', path: 'assets/icons/office365.svg');
  static const CoreIcons okay =
      CoreIcons(name: 'okay', path: 'assets/icons/okay.svg');
  static const CoreIcons onedrive =
      CoreIcons(name: 'onedrive', path: 'assets/icons/onedrive.svg');
  static const CoreIcons open =
      CoreIcons(name: 'open', path: 'assets/icons/open.svg');
  static const CoreIcons otp =
      CoreIcons(name: 'otp', path: 'assets/icons/otp.svg');
  static const CoreIcons paint =
      CoreIcons(name: 'paint', path: 'assets/icons/paint.svg');
  static const CoreIcons pallet =
      CoreIcons(name: 'pallet', path: 'assets/icons/pallet.svg');
  static const CoreIcons parent =
      CoreIcons(name: 'parent', path: 'assets/icons/parent.svg');
  static const CoreIcons parentsevening = CoreIcons(
      name: 'parentsevening', path: 'assets/icons/parentsevening.svg');
  static const CoreIcons paris =
      CoreIcons(name: 'paris', path: 'assets/icons/paris.svg');
  static const CoreIcons people =
      CoreIcons(name: 'people', path: 'assets/icons/people.svg');
  static const CoreIcons permissions =
      CoreIcons(name: 'permissions', path: 'assets/icons/permissions.svg');
  static const CoreIcons pdf =
      CoreIcons(name: 'pdf', path: 'assets/icons/pdf.svg');
  static const CoreIcons person =
      CoreIcons(name: 'person', path: 'assets/icons/person.svg');
  static const CoreIcons pharmacy =
      CoreIcons(name: 'pharmacy', path: 'assets/icons/pharmacy.svg');
  static const CoreIcons plane =
      CoreIcons(name: 'plane', path: 'assets/icons/plane.svg');
  static const CoreIcons play =
      CoreIcons(name: 'play', path: 'assets/icons/play.svg');
  static const CoreIcons plus =
      CoreIcons(name: 'plus', path: 'assets/icons/plus.svg');
  static const CoreIcons podium =
      CoreIcons(name: 'podium', path: 'assets/icons/podium.svg');
  static const CoreIcons powerpoint =
      CoreIcons(name: 'powerpoint', path: 'assets/icons/powerpoint.svg');
  static const CoreIcons presentation =
      CoreIcons(name: 'presentation', path: 'assets/icons/presentation.svg');
  static const CoreIcons print =
      CoreIcons(name: 'print', path: 'assets/icons/print.svg');
  static const CoreIcons protect =
      CoreIcons(name: 'protect', path: 'assets/icons/protect.svg');
  static const CoreIcons pushnotification = CoreIcons(
      name: 'pushnotification', path: 'assets/icons/pushnotification.svg');
  static const CoreIcons racinglap =
      CoreIcons(name: 'racinglap', path: 'assets/icons/racinglap.svg');
  static const CoreIcons rainbow =
      CoreIcons(name: 'rainbow', path: 'assets/icons/rainbow.svg');
  static const CoreIcons record =
      CoreIcons(name: 'record', path: 'assets/icons/record.svg');
  static const CoreIcons refresh =
      CoreIcons(name: 'refresh', path: 'assets/icons/refresh.svg');
  static const CoreIcons reports =
      CoreIcons(name: 'reports', path: 'assets/icons/reports.svg');
  static const CoreIcons reportgraph =
      CoreIcons(name: 'reportgraph', path: 'assets/icons/reportgraph.svg');
  static const CoreIcons reportviewer =
      CoreIcons(name: 'reportviewer', path: 'assets/icons/reportviewer.svg');
  static const CoreIcons reply =
      CoreIcons(name: 'reply', path: 'assets/icons/reply.svg');
  static const CoreIcons restore =
      CoreIcons(name: 'restore', path: 'assets/icons/restore.svg');
  static const CoreIcons review =
      CoreIcons(name: 'review', path: 'assets/icons/review.svg');
  static const CoreIcons richtext =
      CoreIcons(name: 'richtext', path: 'assets/icons/rich_text.svg');
  static const CoreIcons ringingbell =
      CoreIcons(name: 'ringingbell', path: 'assets/icons/ringingbell.svg');
  static const CoreIcons realtime =
      CoreIcons(name: 'realtime', path: 'assets/icons/realtime.svg');
  static const CoreIcons salary =
      CoreIcons(name: 'salary', path: 'assets/icons/salary.svg');
  static const CoreIcons sanction =
      CoreIcons(name: 'sanction', path: 'assets/icons/sanction.svg');
  static const CoreIcons save =
      CoreIcons(name: 'save', path: 'assets/icons/save.svg');
  static const CoreIcons saveall =
      CoreIcons(name: 'saveall', path: 'assets/icons/saveall.svg');
  static const CoreIcons schedule =
      CoreIcons(name: 'schedule', path: 'assets/icons/schedule.svg');
  static const CoreIcons school =
      CoreIcons(name: 'school', path: 'assets/icons/school.svg');
  static const CoreIcons searchbar =
      CoreIcons(name: 'searchbar', path: 'assets/icons/searchbar.svg');
  static const CoreIcons search =
      CoreIcons(name: 'search', path: 'assets/icons/search.svg');
  static const CoreIcons searchbook =
      CoreIcons(name: 'searchbook', path: 'assets/icons/searchbook.svg');
  static const CoreIcons searchlist =
      CoreIcons(name: 'searchlist', path: 'assets/icons/searchlist.svg');
  static const CoreIcons secure =
      CoreIcons(name: 'secure', path: 'assets/icons/secure.svg');
  static const CoreIcons secureuser =
      CoreIcons(name: 'secureuser', path: 'assets/icons/secureuser.svg');
  static const CoreIcons sendmessages =
      CoreIcons(name: 'sendmessages', path: 'assets/icons/sendmessages.svg');
  static const CoreIcons sendtoprinter =
      CoreIcons(name: 'sendtoprinter', path: 'assets/icons/sendtoprinter.svg');
  static const CoreIcons seniorhouse =
      CoreIcons(name: 'seniorhouse', path: 'assets/icons/seniorhouse.svg');
  static const CoreIcons settings =
      CoreIcons(name: 'settings', path: 'assets/icons/settings.svg');
  static const CoreIcons shapes =
      CoreIcons(name: 'shapes', path: 'assets/icons/shapes.svg');
  static const CoreIcons share =
      CoreIcons(name: 'share', path: 'assets/icons/share.svg');
  static const CoreIcons showdates =
      CoreIcons(name: 'showdates', path: 'assets/icons/showdates.svg');
  static const CoreIcons showmenu =
      CoreIcons(name: 'showmenu', path: 'assets/icons/showmenu.svg');
  static const CoreIcons spaces =
      CoreIcons(name: 'spaces', path: 'assets/icons/spaces.svg');
  static const CoreIcons specialdate =
      CoreIcons(name: 'specialdate', path: 'assets/icons/specialdate.svg');
  static const CoreIcons specialdates =
      CoreIcons(name: 'specialdates', path: 'assets/icons/specialdates.svg');
  static const CoreIcons spellcheck =
      CoreIcons(name: 'spellcheck', path: 'assets/icons/spellcheck.svg');
  static const CoreIcons staffmember =
      CoreIcons(name: 'staffmember', path: 'assets/icons/staffmember.svg');
  static const CoreIcons starempty =
      CoreIcons(name: 'starempty', path: 'assets/icons/starempty.svg');
  static const CoreIcons starfilled =
      CoreIcons(name: 'starfilled', path: 'assets/icons/starfilled.svg');
  static const CoreIcons stark =
      CoreIcons(name: 'stark', path: 'assets/icons/stark.svg');
  static const CoreIcons start =
      CoreIcons(name: 'start', path: 'assets/icons/start.svg');
  static const CoreIcons stopimpersonating = CoreIcons(
      name: 'stopimpersonating', path: 'assets/icons/stopimpersonating.svg');
  static const CoreIcons stopmasquerading = CoreIcons(
      name: 'stopmasquerade', path: 'assets/icons/stopmasquerading.svg');
  static const CoreIcons student =
      CoreIcons(name: 'student', path: 'assets/icons/student.svg');
  static const CoreIcons students =
      CoreIcons(name: 'students', path: 'assets/icons/students.svg');
  static const CoreIcons studyleave =
      CoreIcons(name: 'studyleave', path: 'assets/icons/studyleave.svg');
  static const CoreIcons success =
      CoreIcons(name: 'success', path: 'assets/icons/success.svg');
  static const CoreIcons swap =
      CoreIcons(name: 'swap', path: 'assets/icons/swap.svg');
  static const CoreIcons summarylist =
      CoreIcons(name: 'summarylist', path: 'assets/icons/summarylist.svg');
  static const CoreIcons systemadmin =
      CoreIcons(name: 'systemadmin', path: 'assets/icons/systemadmin.svg');
  static const CoreIcons teamwork =
      CoreIcons(name: 'teamwork', path: 'assets/icons/teamwork.svg');
  static const CoreIcons teams =
      CoreIcons(name: 'teams', path: 'assets/icons/teams.svg');
  static const CoreIcons teamslesson =
      CoreIcons(name: 'teamslesson', path: 'assets/icons/teamslesson.svg');
  static const CoreIcons test =
      CoreIcons(name: 'test', path: 'assets/icons/test.svg');
  static const CoreIcons testtube =
      CoreIcons(name: 'testtube', path: 'assets/icons/testtube.svg');
  static const CoreIcons tick =
      CoreIcons(name: 'tick', path: 'assets/icons/tick.svg');
  static const CoreIcons tickcircled =
      CoreIcons(name: 'tickcircled', path: 'assets/icons/tickcircled.svg');
  static const CoreIcons tickcross =
      CoreIcons(name: 'tickcross', path: 'assets/icons/tickcross.svg');
  static const CoreIcons ticketpurchase = CoreIcons(
      name: 'ticketpurchase', path: 'assets/icons/ticketpurchase.svg');
  static const CoreIcons timeMachine =
      CoreIcons(name: 'timeMachine', path: 'assets/icons/time_machine.svg');
  static const CoreIcons todolist =
      CoreIcons(name: 'todolist', path: 'assets/icons/todolist.svg');
  static const CoreIcons todoist =
      CoreIcons(name: 'todoist', path: 'assets/icons/todoist.svg');
  static const CoreIcons tools =
      CoreIcons(name: 'tools', path: 'assets/icons/tools.svg');
  static const CoreIcons torin =
      CoreIcons(name: 'torin', path: 'assets/icons/torin.svg');
  static const CoreIcons transactions =
      CoreIcons(name: 'transactions', path: 'assets/icons/transactions.svg');
  static const CoreIcons transfer =
      CoreIcons(name: 'transfer', path: 'assets/icons/transfer.svg');
  static const CoreIcons treatment =
      CoreIcons(name: 'treatment', path: 'assets/icons/treatment.svg');
  static const CoreIcons unavailable =
      CoreIcons(name: 'unavailable', path: 'assets/icons/unavailable.svg');
  static const CoreIcons undo =
      CoreIcons(name: 'undo', path: 'assets/icons/undo.svg');
  static const CoreIcons update =
      CoreIcons(name: 'update', path: 'assets/icons/update.svg');
  static const CoreIcons upload =
      CoreIcons(name: 'upload', path: 'assets/icons/upload.svg');
  static const CoreIcons upgrade =
      CoreIcons(name: 'upgrade', path: 'assets/icons/upgrade.svg');
  static const CoreIcons user =
      CoreIcons(name: 'user', path: 'assets/icons/user.svg');
  static const CoreIcons usersettings =
      CoreIcons(name: 'usersettings', path: 'assets/icons/usersettings.svg');
  static const CoreIcons usertick =
      CoreIcons(name: 'usertick', path: 'assets/icons/usertick.svg');
  static const CoreIcons vectare =
      CoreIcons(name: 'vectare', path: 'assets/icons/vectare.svg');
  static const CoreIcons vip =
      CoreIcons(name: 'vip', path: 'assets/icons/vip.svg');
  static const CoreIcons video =
      CoreIcons(name: 'video', path: 'assets/icons/video.svg');
  static const CoreIcons view =
      CoreIcons(name: 'view', path: 'assets/icons/view.svg');
  static const CoreIcons viewfile =
      CoreIcons(name: 'viewfile', path: 'assets/icons/viewfile.svg');
  static const CoreIcons warning =
      CoreIcons(name: 'warning', path: 'assets/icons/warning.svg');
  static const CoreIcons web =
      CoreIcons(name: 'web', path: 'assets/icons/web.svg');
  static const CoreIcons wfh =
      CoreIcons(name: 'wfh', path: 'assets/icons/wfh.svg');
  static const CoreIcons windows =
      CoreIcons(name: 'windows', path: 'assets/icons/windows.svg');
  static const CoreIcons worddocument =
      CoreIcons(name: 'worddocument', path: 'assets/icons/worddocument.svg');
  static const CoreIcons workstation =
      CoreIcons(name: 'workstation', path: 'assets/icons/workstation.svg');
  static const CoreIcons world =
      CoreIcons(name: 'world', path: 'assets/icons/world.svg');
}
