class PanopticIcons {
  final String? name;
  final String? path;

  const PanopticIcons({this.name, this.path});

  static PanopticIcons getIcon(String? fileExtension) {
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

  static PanopticIcons getIconForName(String? iconName) {
    if (iconName == null) return PanopticIcons.modules;

    iconName = iconName.toLowerCase();

    return coreIcons.firstWhere(
        (element) => element.name!.toLowerCase() == iconName,
        orElse: () => PanopticIcons.modules);
  }

  static PanopticIcons getIconForEvent(String subject) {
    if (subject.toLowerCase().contains("parents") &&
        subject.toLowerCase().contains("evening")) {
      return PanopticIcons.parentsevening;
    }
    if (subject.toLowerCase().contains("lunch")) {
      return PanopticIcons.lunch;
    }
    if (subject.toLowerCase().contains("break")) {
      return PanopticIcons.breaks;
    }
    if (subject.toLowerCase().contains("paternity")) {
      return PanopticIcons.baby;
    }
    if (subject.toLowerCase().contains("maternity")) {
      return PanopticIcons.baby;
    }
    if (subject.toLowerCase().contains("teams lesson")) {
      return PanopticIcons.teamslesson;
    }
    if (subject.toLowerCase().contains("wfh")) {
      return PanopticIcons.wfh;
    }
    if (subject.toLowerCase().contains("working from home")) {
      return PanopticIcons.wfh;
    }
    if (subject.toLowerCase().contains("remote")) {
      return PanopticIcons.wfh;
    }
    return PanopticIcons.event;
  }

  static List<PanopticIcons> coreIcons = [
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

  static const PanopticIcons aboutme =
      PanopticIcons(name: 'aboutme', path: 'assets/icons_svg/about_me.svg');
  static const PanopticIcons accidentplus = PanopticIcons(
      name: 'accidentplus', path: 'assets/icons_svg/accidentplus.svg');
  static const PanopticIcons accidentbook = PanopticIcons(
      name: 'accidentbook', path: 'assets/icons_svg/accidentbook.svg');
  static const PanopticIcons accidentreporting = PanopticIcons(
      name: 'accidentreporting',
      path: 'assets/icons_svg/accidentreporting.svg');
  static const PanopticIcons add =
      PanopticIcons(name: 'add', path: 'assets/icons_svg/add.svg');
  static const PanopticIcons adddate =
      PanopticIcons(name: 'adddate', path: 'assets/icons_svg/adddate.svg');
  static const PanopticIcons adddocument = PanopticIcons(
      name: 'adddocument', path: 'assets/icons_svg/adddocument.svg');
  static const PanopticIcons addlink =
      PanopticIcons(name: 'addlink', path: 'assets/icons_svg/addlink.svg');
  static const PanopticIcons agile =
      PanopticIcons(name: 'agile', path: 'assets/icons_svg/agile.svg');
  static const PanopticIcons agilereport = PanopticIcons(
      name: 'agilereport', path: 'assets/icons_svg/agilereport.svg');
  static const PanopticIcons ai =
      PanopticIcons(name: 'ai', path: 'assets/icons_svg/ai.svg');
  static const PanopticIcons analytics =
      PanopticIcons(name: 'analytics', path: 'assets/icons_svg/analytics.svg');
  static const PanopticIcons api =
      PanopticIcons(name: 'api', path: 'assets/icons_svg/api.svg');
  static const PanopticIcons apps =
      PanopticIcons(name: 'apps', path: 'assets/icons_svg/apps.svg');
  static const PanopticIcons archive =
      PanopticIcons(name: 'archive', path: 'assets/icons_svg/archive.svg');
  static const PanopticIcons attendance = PanopticIcons(
      name: 'attendance', path: 'assets/icons_svg/attendance.svg');
  static const PanopticIcons award =
      PanopticIcons(name: 'award', path: 'assets/icons_svg/award.svg');
  static const PanopticIcons baby =
      PanopticIcons(name: 'baby', path: 'assets/icons_svg/baby.svg');
  static const PanopticIcons barcode =
      PanopticIcons(name: 'barcode', path: 'assets/icons_svg/barcode.svg');
  static const PanopticIcons billing =
      PanopticIcons(name: 'billing', path: 'assets/icons_svg/billing.svg');
  static const PanopticIcons bin =
      PanopticIcons(name: 'bin', path: 'assets/icons_svg/bin.svg');
  static const PanopticIcons book =
      PanopticIcons(name: 'book', path: 'assets/icons_svg/book.svg');
  static const PanopticIcons bookreading = PanopticIcons(
      name: 'bookreading', path: 'assets/icons_svg/bookreading.svg');
  static const PanopticIcons books =
      PanopticIcons(name: 'books', path: 'assets/icons_svg/books.svg');
  static const PanopticIcons bookmarkhome = PanopticIcons(
      name: 'bookmarkhome', path: 'assets/icons_svg/bookmarkhome.svg');
  static const PanopticIcons brain =
      PanopticIcons(name: 'brain', path: 'assets/icons_svg/brain.svg');
  static const PanopticIcons breaks =
      PanopticIcons(name: 'breaks', path: 'assets/icons_svg/breaks.svg');
  static const PanopticIcons caduceus =
      PanopticIcons(name: 'caduceus', path: 'assets/icons_svg/caduceus.svg');
  static const PanopticIcons calendar =
      PanopticIcons(name: 'calendar', path: 'assets/icons_svg/calendar.svg');
  static const PanopticIcons cat =
      PanopticIcons(name: 'cat', path: 'assets/icons_svg/cat.svg');
  static const PanopticIcons catalyst =
      PanopticIcons(name: 'catalyst', path: 'assets/icons_svg/catalyst.svg');
  static const PanopticIcons chat =
      PanopticIcons(name: 'chat', path: 'assets/icons_svg/chat.svg');
  static const PanopticIcons chatcall =
      PanopticIcons(name: 'chatcall', path: 'assets/icons_svg/chatcall.svg');
  static const PanopticIcons checklist =
      PanopticIcons(name: 'checklist', path: 'assets/icons_svg/checklist.svg');
  static const PanopticIcons chevrondown = PanopticIcons(
      name: 'chevrondown', path: 'assets/icons_svg/chevrondown.svg');
  static const PanopticIcons chevronleft = PanopticIcons(
      name: 'chevronleft', path: 'assets/icons_svg/chevronleft.svg');
  static const PanopticIcons chevronright = PanopticIcons(
      name: 'chevronright', path: 'assets/icons_svg/chevronright.svg');
  static const PanopticIcons chevronup =
      PanopticIcons(name: 'chevronup', path: 'assets/icons_svg/chevronup.svg');
  static const PanopticIcons choice =
      PanopticIcons(name: 'choice', path: 'assets/icons_svg/choice.svg');
  static const PanopticIcons classsync =
      PanopticIcons(name: 'classsync', path: 'assets/icons_svg/classsync.svg');
  static const PanopticIcons classroom =
      PanopticIcons(name: 'classroom', path: 'assets/icons_svg/classroom.svg');
  static const PanopticIcons clear =
      PanopticIcons(name: 'clear', path: 'assets/icons_svg/clear.svg');
  static const PanopticIcons clearbookmark = PanopticIcons(
      name: 'clearbookmark', path: 'assets/icons_svg/clearbookmark.svg');
  static const PanopticIcons clipboard =
      PanopticIcons(name: 'clipboard', path: 'assets/icons_svg/clipboard.svg');
  static const PanopticIcons cloudsync =
      PanopticIcons(name: 'cloudsync', path: 'assets/icons_svg/cloudsync.svg');
  static const PanopticIcons collapse =
      PanopticIcons(name: 'collapse', path: 'assets/icons_svg/collapse.svg');
  static const PanopticIcons comment =
      PanopticIcons(name: 'comment', path: 'assets/icons_svg/comment.svg');
  static const PanopticIcons commercial = PanopticIcons(
      name: 'commercial', path: 'assets/icons_svg/commercial.svg');
  static const PanopticIcons contactcard = PanopticIcons(
      name: 'contactcard', path: 'assets/icons_svg/contactcard.svg');
  static const PanopticIcons copy =
      PanopticIcons(name: 'copy', path: 'assets/icons_svg/copy.svg');
  static const PanopticIcons cpoms =
      PanopticIcons(name: 'cpoms', path: 'assets/icons_svg/cpoms.svg');
  static const PanopticIcons creategroup = PanopticIcons(
      name: 'creategroup', path: 'assets/icons_svg/creategroup.svg');
  static const PanopticIcons createpage = PanopticIcons(
      name: 'createpage', path: 'assets/icons_svg/createpage.svg');
  static const PanopticIcons critical =
      PanopticIcons(name: 'critical', path: 'assets/icons_svg/critical.svg');
  static const PanopticIcons cross =
      PanopticIcons(name: 'cross', path: 'assets/icons_svg/cross.svg');
  static const PanopticIcons dash =
      PanopticIcons(name: 'dash', path: 'assets/icons_svg/dash.svg');
  static const PanopticIcons dashboard =
      PanopticIcons(name: 'dashboard', path: 'assets/icons_svg/dashboard.svg');
  static const PanopticIcons dataentry =
      PanopticIcons(name: 'dataentry', path: 'assets/icons_svg/dataentry.svg');
  static const PanopticIcons dateSettings = PanopticIcons(
      name: 'dateSettings', path: 'assets/icons_svg/datesettings.svg');
  static const PanopticIcons delete =
      PanopticIcons(name: 'delete', path: 'assets/icons_svg/delete.svg');
  static const PanopticIcons diamond =
      PanopticIcons(name: 'diamond', path: 'assets/icons_svg/diamond.svg');
  static const PanopticIcons dice =
      PanopticIcons(name: 'dice', path: 'assets/icons_svg/dice.svg');
  static const PanopticIcons document =
      PanopticIcons(name: 'document', path: 'assets/icons_svg/document.svg');
  static const PanopticIcons dog =
      PanopticIcons(name: 'dog', path: 'assets/icons_svg/dog.svg');
  static const PanopticIcons doubleleft = PanopticIcons(
      name: 'doubleleft', path: 'assets/icons_svg/doubleleft.svg');
  static const PanopticIcons doubleright = PanopticIcons(
      name: 'doubleright', path: 'assets/icons_svg/doubleright.svg');
  static const PanopticIcons download =
      PanopticIcons(name: 'download', path: 'assets/icons_svg/download.svg');
  static const PanopticIcons downloadxls = PanopticIcons(
      name: 'downloadxls', path: 'assets/icons_svg/downloadxls.svg');
  static const PanopticIcons duplicate =
      PanopticIcons(name: 'duplicate', path: 'assets/icons_svg/duplicate.svg');
  static const PanopticIcons edit =
      PanopticIcons(name: 'edit', path: 'assets/icons_svg/edit.svg');
  static const PanopticIcons editdetails = PanopticIcons(
      name: 'editdetails', path: 'assets/icons_svg/editdetails.svg');
  static const PanopticIcons editreport = PanopticIcons(
      name: 'editreport', path: 'assets/icons_svg/editreport.svg');
  static const PanopticIcons elearning =
      PanopticIcons(name: 'elearning', path: 'assets/icons_svg/elearning.svg');
  static const PanopticIcons email =
      PanopticIcons(name: 'email', path: 'assets/icons_svg/email.svg');
  static const PanopticIcons emailsignature = PanopticIcons(
      name: 'emailsignature', path: 'assets/icons_svg/emailsignature.svg');
  static const PanopticIcons empty =
      PanopticIcons(name: 'empty', path: 'assets/icons_svg/empty.svg');
  static const PanopticIcons epipen =
      PanopticIcons(name: 'epipen', path: 'assets/icons_svg/epipen.svg');
  static const PanopticIcons error =
      PanopticIcons(name: 'error', path: 'assets/icons_svg/error.svg');
  static const PanopticIcons event =
      PanopticIcons(name: 'event', path: 'assets/icons_svg/event.svg');
  static const PanopticIcons eventTime =
      PanopticIcons(name: 'eventTime', path: 'assets/icons_svg/event_time.svg');
  static const PanopticIcons eventSignup = PanopticIcons(
      name: 'eventSignup', path: 'assets/icons_svg/eventsignup.svg');
  static const PanopticIcons exam =
      PanopticIcons(name: 'exam', path: 'assets/icons_svg/exam.svg');
  static const PanopticIcons examresults = PanopticIcons(
      name: 'examresults', path: 'assets/icons_svg/examresults.svg');
  static const PanopticIcons exceldocument = PanopticIcons(
      name: 'exceldocument', path: 'assets/icons_svg/exceldocument.svg');
  static const PanopticIcons expand =
      PanopticIcons(name: 'expand', path: 'assets/icons_svg/expand.svg');
  static const PanopticIcons experiment = PanopticIcons(
      name: 'experiment', path: 'assets/icons_svg/experiment.svg');
  static const PanopticIcons external =
      PanopticIcons(name: 'external', path: 'assets/icons_svg/external.svg');
  static const PanopticIcons eye =
      PanopticIcons(name: 'eye', path: 'assets/icons_svg/eye.svg');
  static const PanopticIcons favouriteEmpty = PanopticIcons(
      name: 'favouriteEmpty', path: 'assets/icons_svg/favempty.svg');
  static const PanopticIcons favouriteFilled = PanopticIcons(
      name: 'favouriteFilled', path: 'assets/icons_svg/favfilled.svg');
  static const PanopticIcons file =
      PanopticIcons(name: 'file', path: 'assets/icons_svg/file.svg');
  static const PanopticIcons filter =
      PanopticIcons(name: 'filter', path: 'assets/icons_svg/filter.svg');
  static const PanopticIcons finish =
      PanopticIcons(name: 'finish', path: 'assets/icons_svg/finish.svg');
  static const PanopticIcons fire =
      PanopticIcons(name: 'fire', path: 'assets/icons_svg/fire.svg');
  static const PanopticIcons firefly =
      PanopticIcons(name: 'firefly', path: 'assets/icons_svg/firefly.svg');
  static const PanopticIcons folder =
      PanopticIcons(name: 'folder', path: 'assets/icons_svg/folder.svg');
  static const PanopticIcons form =
      PanopticIcons(name: 'form', path: 'assets/icons_svg/form.svg');
  static const PanopticIcons freeperiods = PanopticIcons(
      name: 'freeperiods', path: 'assets/icons_svg/freeperiods.svg');
  static const PanopticIcons goal =
      PanopticIcons(name: 'goal', path: 'assets/icons_svg/goal.svg');
  static const PanopticIcons guitarist =
      PanopticIcons(name: 'guitarist', path: 'assets/icons_svg/guitarist.svg');
  static const PanopticIcons health =
      PanopticIcons(name: 'health', path: 'assets/icons_svg/health.svg');
  static const PanopticIcons heartplus =
      PanopticIcons(name: 'heartplus', path: 'assets/icons_svg/heartplus.svg');
  static const PanopticIcons heartwithdots = PanopticIcons(
      name: 'heartwithdots', path: 'assets/icons_svg/heartwithdots.svg');
  static const PanopticIcons heartwithpulse = PanopticIcons(
      name: 'heartwithpulse', path: 'assets/icons_svg/heartwithpulse.svg');
  static const PanopticIcons heartwithtick = PanopticIcons(
      name: 'heartwithtick', path: 'assets/icons_svg/heartwithtick.svg');
  static const PanopticIcons help =
      PanopticIcons(name: 'help', path: 'assets/icons_svg/help.svg');
  static const PanopticIcons helpdesk =
      PanopticIcons(name: 'helpdesk', path: 'assets/icons_svg/helpdesk.svg');
  static const PanopticIcons hidemenu =
      PanopticIcons(name: 'hidemenu', path: 'assets/icons_svg/hidemenu.svg');
  static const PanopticIcons house =
      PanopticIcons(name: 'house', path: 'assets/icons_svg/house.svg');
  static const PanopticIcons hourglass =
      PanopticIcons(name: 'houseglass', path: 'assets/icons_svg/hourglass.svg');
  static const PanopticIcons idcard =
      PanopticIcons(name: 'idcard', path: 'assets/icons_svg/idcard.svg');
  static const PanopticIcons image =
      PanopticIcons(name: 'image', path: 'assets/icons_svg/image.svg');
  static const PanopticIcons important =
      PanopticIcons(name: 'important', path: 'assets/icons_svg/important.svg');
  static const PanopticIcons importantbook = PanopticIcons(
      name: 'importantbook', path: 'assets/icons_svg/importantbook.svg');
  static const PanopticIcons improvement = PanopticIcons(
      name: 'improvement', path: 'assets/icons_svg/improvement.svg');
  static const PanopticIcons inprogress = PanopticIcons(
      name: 'inprogress', path: 'assets/icons_svg/inprogress.svg');
  static const PanopticIcons info =
      PanopticIcons(name: 'info', path: 'assets/icons_svg/info.svg');
  static const PanopticIcons infoRound =
      PanopticIcons(name: 'infoRound', path: 'assets/icons_svg/info_round.svg');
  static const PanopticIcons inhaler =
      PanopticIcons(name: 'inhaler', path: 'assets/icons_svg/inhaler.svg');
  static const PanopticIcons instruments = PanopticIcons(
      name: 'instruments', path: 'assets/icons_svg/instruments.svg');
  static const PanopticIcons internal =
      PanopticIcons(name: 'internal', path: 'assets/icons_svg/internal.svg');
  static const PanopticIcons keyboard =
      PanopticIcons(name: 'keyboard', path: 'assets/icons_svg/keyboard.svg');
  static const PanopticIcons leaverequest = PanopticIcons(
      name: 'leaverequest', path: 'assets/icons_svg/leaverequest.svg');
  static const PanopticIcons lecture =
      PanopticIcons(name: 'lecture', path: 'assets/icons_svg/lecture.svg');
  static const PanopticIcons link =
      PanopticIcons(name: 'link', path: 'assets/icons_svg/link.svg');
  static const PanopticIcons linkedin =
      PanopticIcons(name: 'linkedin', path: 'assets/icons_svg/linkedin.svg');
  static const PanopticIcons list =
      PanopticIcons(name: 'list', path: 'assets/icons_svg/list.svg');
  static const PanopticIcons lock =
      PanopticIcons(name: 'lock', path: 'assets/icons_svg/lock.svg');
  static const PanopticIcons lowimportance = PanopticIcons(
      name: 'lowimportance', path: 'assets/icons_svg/lowimportance.svg');
  static const PanopticIcons lunch =
      PanopticIcons(name: 'lunch', path: 'assets/icons_svg/lunch.svg');
  static const PanopticIcons mailings =
      PanopticIcons(name: 'mailings', path: 'assets/icons_svg/mailings.svg');
  static const PanopticIcons map =
      PanopticIcons(name: 'map', path: 'assets/icons_svg/map.svg');
  static const PanopticIcons masquerade = PanopticIcons(
      name: 'masquerade', path: 'assets/icons_svg/masquerade.svg');
  static const PanopticIcons medal =
      PanopticIcons(name: 'medal', path: 'assets/icons_svg/medal.svg');
  static const PanopticIcons medical =
      PanopticIcons(name: 'medical', path: 'assets/icons_svg/medical.svg');
  static const PanopticIcons medicalbed = PanopticIcons(
      name: 'medicalbed', path: 'assets/icons_svg/medicalbed.svg');
  static const PanopticIcons medicalbook = PanopticIcons(
      name: 'medicalbook', path: 'assets/icons_svg/medicalbook.svg');
  static const PanopticIcons medicallaptop = PanopticIcons(
      name: 'medicallaptop', path: 'assets/icons_svg/medicallaptop.svg');
  static const PanopticIcons medication = PanopticIcons(
      name: 'medication', path: 'assets/icons_svg/medication.svg');
  static const PanopticIcons meeting =
      PanopticIcons(name: 'meeting', path: 'assets/icons_svg/meeting.svg');
  static const PanopticIcons meetingtime = PanopticIcons(
      name: 'meetingtime', path: 'assets/icons_svg/meetingtime.svg');
  static const PanopticIcons mentor =
      PanopticIcons(name: 'mentor', path: 'assets/icons_svg/mentor.svg');
  static const PanopticIcons modules =
      PanopticIcons(name: 'modules', path: 'assets/icons_svg/modules.svg');
  static const PanopticIcons more =
      PanopticIcons(name: 'more', path: 'assets/icons_svg/more.svg');
  static const PanopticIcons morefilled = PanopticIcons(
      name: 'morefilled', path: 'assets/icons_svg/more_filled.svg');
  static const PanopticIcons musicbook =
      PanopticIcons(name: 'musicbook', path: 'assets/icons_svg/musicbook.svg');
  static const PanopticIcons musicconductor = PanopticIcons(
      name: 'musicconductor', path: 'assets/icons_svg/musicconductor.svg');
  static const PanopticIcons news =
      PanopticIcons(name: 'news', path: 'assets/icons_svg/news.svg');
  static const PanopticIcons notfound =
      PanopticIcons(name: 'notfound', path: 'assets/icons_svg/notfound.svg');
  static const PanopticIcons notification = PanopticIcons(
      name: 'notification', path: 'assets/icons_svg/notification.svg');
  static const PanopticIcons notify =
      PanopticIcons(name: 'notify', path: 'assets/icons_svg/notify.svg');
  static const PanopticIcons noticeboard = PanopticIcons(
      name: 'noticeboard', path: 'assets/icons_svg/noticeboard.svg');
  static const PanopticIcons notes =
      PanopticIcons(name: 'notes', path: 'assets/icons_svg/notes.svg');
  static const PanopticIcons number =
      PanopticIcons(name: 'number', path: 'assets/icons_svg/number.svg');
  static const PanopticIcons office365 =
      PanopticIcons(name: 'office365', path: 'assets/icons_svg/office365.svg');
  static const PanopticIcons okay =
      PanopticIcons(name: 'okay', path: 'assets/icons_svg/okay.svg');
  static const PanopticIcons onedrive =
      PanopticIcons(name: 'onedrive', path: 'assets/icons_svg/onedrive.svg');
  static const PanopticIcons open =
      PanopticIcons(name: 'open', path: 'assets/icons_svg/open.svg');
  static const PanopticIcons otp =
      PanopticIcons(name: 'otp', path: 'assets/icons_svg/otp.svg');
  static const PanopticIcons paint =
      PanopticIcons(name: 'paint', path: 'assets/icons_svg/paint.svg');
  static const PanopticIcons pallet =
      PanopticIcons(name: 'pallet', path: 'assets/icons_svg/pallet.svg');
  static const PanopticIcons parent =
      PanopticIcons(name: 'parent', path: 'assets/icons_svg/parent.svg');
  static const PanopticIcons parentsevening = PanopticIcons(
      name: 'parentsevening', path: 'assets/icons_svg/parentsevening.svg');
  static const PanopticIcons paris =
      PanopticIcons(name: 'paris', path: 'assets/icons_svg/paris.svg');
  static const PanopticIcons people =
      PanopticIcons(name: 'people', path: 'assets/icons_svg/people.svg');
  static const PanopticIcons permissions = PanopticIcons(
      name: 'permissions', path: 'assets/icons_svg/permissions.svg');
  static const PanopticIcons pdf =
      PanopticIcons(name: 'pdf', path: 'assets/icons_svg/pdf.svg');
  static const PanopticIcons person =
      PanopticIcons(name: 'person', path: 'assets/icons_svg/person.svg');
  static const PanopticIcons pharmacy =
      PanopticIcons(name: 'pharmacy', path: 'assets/icons_svg/pharmacy.svg');
  static const PanopticIcons plane =
      PanopticIcons(name: 'plane', path: 'assets/icons_svg/plane.svg');
  static const PanopticIcons play =
      PanopticIcons(name: 'play', path: 'assets/icons_svg/play.svg');
  static const PanopticIcons plus =
      PanopticIcons(name: 'plus', path: 'assets/icons_svg/plus.svg');
  static const PanopticIcons podium =
      PanopticIcons(name: 'podium', path: 'assets/icons_svg/podium.svg');
  static const PanopticIcons powerpoint = PanopticIcons(
      name: 'powerpoint', path: 'assets/icons_svg/powerpoint.svg');
  static const PanopticIcons presentation = PanopticIcons(
      name: 'presentation', path: 'assets/icons_svg/presentation.svg');
  static const PanopticIcons print =
      PanopticIcons(name: 'print', path: 'assets/icons_svg/print.svg');
  static const PanopticIcons protect =
      PanopticIcons(name: 'protect', path: 'assets/icons_svg/protect.svg');
  static const PanopticIcons pushnotification = PanopticIcons(
      name: 'pushnotification', path: 'assets/icons_svg/pushnotification.svg');
  static const PanopticIcons racinglap =
      PanopticIcons(name: 'racinglap', path: 'assets/icons_svg/racinglap.svg');
  static const PanopticIcons rainbow =
      PanopticIcons(name: 'rainbow', path: 'assets/icons_svg/rainbow.svg');
  static const PanopticIcons record =
      PanopticIcons(name: 'record', path: 'assets/icons_svg/record.svg');
  static const PanopticIcons refresh =
      PanopticIcons(name: 'refresh', path: 'assets/icons_svg/refresh.svg');
  static const PanopticIcons reports =
      PanopticIcons(name: 'reports', path: 'assets/icons_svg/reports.svg');
  static const PanopticIcons reportgraph = PanopticIcons(
      name: 'reportgraph', path: 'assets/icons_svg/reportgraph.svg');
  static const PanopticIcons reportviewer = PanopticIcons(
      name: 'reportviewer', path: 'assets/icons_svg/reportviewer.svg');
  static const PanopticIcons reply =
      PanopticIcons(name: 'reply', path: 'assets/icons_svg/reply.svg');
  static const PanopticIcons restore =
      PanopticIcons(name: 'restore', path: 'assets/icons_svg/restore.svg');
  static const PanopticIcons review =
      PanopticIcons(name: 'review', path: 'assets/icons_svg/review.svg');
  static const PanopticIcons richtext =
      PanopticIcons(name: 'richtext', path: 'assets/icons_svg/rich_text.svg');
  static const PanopticIcons ringingbell = PanopticIcons(
      name: 'ringingbell', path: 'assets/icons_svg/ringingbell.svg');
  static const PanopticIcons realtime =
      PanopticIcons(name: 'realtime', path: 'assets/icons_svg/realtime.svg');
  static const PanopticIcons salary =
      PanopticIcons(name: 'salary', path: 'assets/icons_svg/salary.svg');
  static const PanopticIcons sanction =
      PanopticIcons(name: 'sanction', path: 'assets/icons_svg/sanction.svg');
  static const PanopticIcons save =
      PanopticIcons(name: 'save', path: 'assets/icons_svg/save.svg');
  static const PanopticIcons saveall =
      PanopticIcons(name: 'saveall', path: 'assets/icons_svg/saveall.svg');
  static const PanopticIcons schedule =
      PanopticIcons(name: 'schedule', path: 'assets/icons_svg/schedule.svg');
  static const PanopticIcons school =
      PanopticIcons(name: 'school', path: 'assets/icons_svg/school.svg');
  static const PanopticIcons searchbar =
      PanopticIcons(name: 'searchbar', path: 'assets/icons_svg/searchbar.svg');
  static const PanopticIcons search =
      PanopticIcons(name: 'search', path: 'assets/icons_svg/search.svg');
  static const PanopticIcons searchbook = PanopticIcons(
      name: 'searchbook', path: 'assets/icons_svg/searchbook.svg');
  static const PanopticIcons searchlist = PanopticIcons(
      name: 'searchlist', path: 'assets/icons_svg/searchlist.svg');
  static const PanopticIcons secure =
      PanopticIcons(name: 'secure', path: 'assets/icons_svg/secure.svg');
  static const PanopticIcons secureuser = PanopticIcons(
      name: 'secureuser', path: 'assets/icons_svg/secureuser.svg');
  static const PanopticIcons sendmessages = PanopticIcons(
      name: 'sendmessages', path: 'assets/icons_svg/sendmessages.svg');
  static const PanopticIcons sendtoprinter = PanopticIcons(
      name: 'sendtoprinter', path: 'assets/icons_svg/sendtoprinter.svg');
  static const PanopticIcons seniorhouse = PanopticIcons(
      name: 'seniorhouse', path: 'assets/icons_svg/seniorhouse.svg');
  static const PanopticIcons settings =
      PanopticIcons(name: 'settings', path: 'assets/icons_svg/settings.svg');
  static const PanopticIcons shapes =
      PanopticIcons(name: 'shapes', path: 'assets/icons_svg/shapes.svg');
  static const PanopticIcons share =
      PanopticIcons(name: 'share', path: 'assets/icons_svg/share.svg');
  static const PanopticIcons showdates =
      PanopticIcons(name: 'showdates', path: 'assets/icons_svg/showdates.svg');
  static const PanopticIcons showmenu =
      PanopticIcons(name: 'showmenu', path: 'assets/icons_svg/showmenu.svg');
  static const PanopticIcons spaces =
      PanopticIcons(name: 'spaces', path: 'assets/icons_svg/spaces.svg');
  static const PanopticIcons specialdate = PanopticIcons(
      name: 'specialdate', path: 'assets/icons_svg/specialdate.svg');
  static const PanopticIcons specialdates = PanopticIcons(
      name: 'specialdates', path: 'assets/icons_svg/specialdates.svg');
  static const PanopticIcons spellcheck = PanopticIcons(
      name: 'spellcheck', path: 'assets/icons_svg/spellcheck.svg');
  static const PanopticIcons staffmember = PanopticIcons(
      name: 'staffmember', path: 'assets/icons_svg/staffmember.svg');
  static const PanopticIcons starempty =
      PanopticIcons(name: 'starempty', path: 'assets/icons_svg/starempty.svg');
  static const PanopticIcons starfilled = PanopticIcons(
      name: 'starfilled', path: 'assets/icons_svg/starfilled.svg');
  static const PanopticIcons stark =
      PanopticIcons(name: 'stark', path: 'assets/icons_svg/stark.svg');
  static const PanopticIcons start =
      PanopticIcons(name: 'start', path: 'assets/icons_svg/start.svg');
  static const PanopticIcons stopimpersonating = PanopticIcons(
      name: 'stopimpersonating',
      path: 'assets/icons_svg/stopimpersonating.svg');
  static const PanopticIcons stopmasquerading = PanopticIcons(
      name: 'stopmasquerade', path: 'assets/icons_svg/stopmasquerading.svg');
  static const PanopticIcons student =
      PanopticIcons(name: 'student', path: 'assets/icons_svg/student.svg');
  static const PanopticIcons students =
      PanopticIcons(name: 'students', path: 'assets/icons_svg/students.svg');
  static const PanopticIcons studyleave = PanopticIcons(
      name: 'studyleave', path: 'assets/icons_svg/studyleave.svg');
  static const PanopticIcons success =
      PanopticIcons(name: 'success', path: 'assets/icons_svg/success.svg');
  static const PanopticIcons swap =
      PanopticIcons(name: 'swap', path: 'assets/icons_svg/swap.svg');
  static const PanopticIcons summarylist = PanopticIcons(
      name: 'summarylist', path: 'assets/icons_svg/summarylist.svg');
  static const PanopticIcons systemadmin = PanopticIcons(
      name: 'systemadmin', path: 'assets/icons_svg/systemadmin.svg');
  static const PanopticIcons teamwork =
      PanopticIcons(name: 'teamwork', path: 'assets/icons_svg/teamwork.svg');
  static const PanopticIcons teams =
      PanopticIcons(name: 'teams', path: 'assets/icons_svg/teams.svg');
  static const PanopticIcons teamslesson = PanopticIcons(
      name: 'teamslesson', path: 'assets/icons_svg/teamslesson.svg');
  static const PanopticIcons test =
      PanopticIcons(name: 'test', path: 'assets/icons_svg/test.svg');
  static const PanopticIcons testtube =
      PanopticIcons(name: 'testtube', path: 'assets/icons_svg/testtube.svg');
  static const PanopticIcons tick =
      PanopticIcons(name: 'tick', path: 'assets/icons_svg/tick.svg');
  static const PanopticIcons tickcircled = PanopticIcons(
      name: 'tickcircled', path: 'assets/icons_svg/tickcircled.svg');
  static const PanopticIcons tickcross =
      PanopticIcons(name: 'tickcross', path: 'assets/icons_svg/tickcross.svg');
  static const PanopticIcons ticketpurchase = PanopticIcons(
      name: 'ticketpurchase', path: 'assets/icons_svg/ticketpurchase.svg');
  static const PanopticIcons timeMachine = PanopticIcons(
      name: 'timeMachine', path: 'assets/icons_svg/time_machine.svg');
  static const PanopticIcons todolist =
      PanopticIcons(name: 'todolist', path: 'assets/icons_svg/todolist.svg');
  static const PanopticIcons todoist =
      PanopticIcons(name: 'todoist', path: 'assets/icons_svg/todoist.svg');
  static const PanopticIcons tools =
      PanopticIcons(name: 'tools', path: 'assets/icons_svg/tools.svg');
  static const PanopticIcons torin =
      PanopticIcons(name: 'torin', path: 'assets/icons_svg/torin.svg');
  static const PanopticIcons transactions = PanopticIcons(
      name: 'transactions', path: 'assets/icons_svg/transactions.svg');
  static const PanopticIcons transfer =
      PanopticIcons(name: 'transfer', path: 'assets/icons_svg/transfer.svg');
  static const PanopticIcons treatment =
      PanopticIcons(name: 'treatment', path: 'assets/icons_svg/treatment.svg');
  static const PanopticIcons unavailable = PanopticIcons(
      name: 'unavailable', path: 'assets/icons_svg/unavailable.svg');
  static const PanopticIcons undo =
      PanopticIcons(name: 'undo', path: 'assets/icons_svg/undo.svg');
  static const PanopticIcons update =
      PanopticIcons(name: 'update', path: 'assets/icons_svg/update.svg');
  static const PanopticIcons upload =
      PanopticIcons(name: 'upload', path: 'assets/icons_svg/upload.svg');
  static const PanopticIcons upgrade =
      PanopticIcons(name: 'upgrade', path: 'assets/icons_svg/upgrade.svg');
  static const PanopticIcons user =
      PanopticIcons(name: 'user', path: 'assets/icons_svg/user.svg');
  static const PanopticIcons usersettings = PanopticIcons(
      name: 'usersettings', path: 'assets/icons_svg/usersettings.svg');
  static const PanopticIcons usertick =
      PanopticIcons(name: 'usertick', path: 'assets/icons_svg/usertick.svg');
  static const PanopticIcons vectare =
      PanopticIcons(name: 'vectare', path: 'assets/icons_svg/vectare.svg');
  static const PanopticIcons vip =
      PanopticIcons(name: 'vip', path: 'assets/icons_svg/vip.svg');
  static const PanopticIcons video =
      PanopticIcons(name: 'video', path: 'assets/icons_svg/video.svg');
  static const PanopticIcons view =
      PanopticIcons(name: 'view', path: 'assets/icons_svg/view.svg');
  static const PanopticIcons viewfile =
      PanopticIcons(name: 'viewfile', path: 'assets/icons_svg/viewfile.svg');
  static const PanopticIcons warning =
      PanopticIcons(name: 'warning', path: 'assets/icons_svg/warning.svg');
  static const PanopticIcons web =
      PanopticIcons(name: 'web', path: 'assets/icons_svg/web.svg');
  static const PanopticIcons wfh =
      PanopticIcons(name: 'wfh', path: 'assets/icons_svg/wfh.svg');
  static const PanopticIcons windows =
      PanopticIcons(name: 'windows', path: 'assets/icons_svg/windows.svg');
  static const PanopticIcons worddocument = PanopticIcons(
      name: 'worddocument', path: 'assets/icons_svg/worddocument.svg');
  static const PanopticIcons workstation = PanopticIcons(
      name: 'workstation', path: 'assets/icons_svg/workstation.svg');
  static const PanopticIcons world =
      PanopticIcons(name: 'world', path: 'assets/icons_svg/world.svg');
}
