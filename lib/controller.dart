bool checkDuplicate(List selectedList) {
  final uniqueList = selectedList.toSet().toList();

  if (uniqueList.length < selectedList.length) {
    return true;
  }
  return false;
}

int computeELR2B2_A(List selectedSubjectValues, List selectedGradeValues) {
  int score = 0;

  List duplicateSubjects = List.from(selectedSubjectValues);

  score += int.parse(
      selectedGradeValues[duplicateSubjects.indexOf('English Language')]
      [1]); //find english grade and add to score

  duplicateSubjects.removeAt(duplicateSubjects.indexOf('English Language'));

  List R1 = [
    'Art/Art & Design',
    'Business Studies',
    'Combined Humanities',
    'Commerce',
    'Commercial Studies',
    'Economics',
    'Geography',
    'Higher Art',
    'Higher Music',
    'History',
    'Humanities (Social Studies, Literature in English)',
    'Humanities (Social Studies, Literature in Chinese)',
    'Humanities (Social Studies, Literature in Malay)',
    'Humanities (Social Studies, Literature in Tamil)',
    'Humanities (Social Studies, History)',
    'Humanities (Social Studies, Geography)',
    'Intro to Enterprise Development',
    'Literature in English',
    'Literature in Chinese',
    'Literature in Malay',
    'Literature in Tamil',
    'Media Studies (English)',
    'Media Studies (Chinese)',
    'Music'
  ];

  List minR1 = [];
  duplicateSubjects.forEach((element) {
    if (R1.contains(element)) minR1.add(element);
  });

  print(minR1);

  int min = 10;
  var minR1Subject;
  minR1.forEach((element) {
    if (min >
        int.parse(
            selectedGradeValues[selectedSubjectValues.indexOf(element)][1])) {
      min = int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
      minR1Subject = element;
    }
  });

  duplicateSubjects.remove(minR1Subject);
  score += min;

  List R2 = [
    'Additional Mathematics',
    'Art/Art & Design',
    'Business Studies',
    'Chinese',
    'Combined Humanities',
    'Commerce',
    'Commercial Studies',
    'Creative 3D Animation',
    'Design & Technology',
    'Design Studies',
    'Economics',
    'Elementary Mathematics',
    'Food & Nutrition',
    'Geography',
    'Higher Art',
    'Higher Chinese',
    'Higher Malay',
    'Higher Music',
    'Higher Tamil',
    'History',
    'Humanities (Social Studies, Literature in English)',
    'Humanities (Social Studies, Literature in Chinese)',
    'Humanities (Social Studies, Literature in Malay)',
    'Humanities (Social Studies, Literature in Tamil)',
    'Humanities (Social Studies, History)',
    'Humanities (Social Studies, Geography)',
    'Intro to Enterprise Development',
    'Literature in English',
    'Literature in Chinese',
    'Literature in Malay',
    'Literature in Tamil',
    'Malay',
    'Media Studies (English)',
    'Media Studies (Chinese)',
    'Music',
    'Principles of Accounts',
    'Tamil',
  ];

  List minR2 = [];
  duplicateSubjects.forEach((element) {
    if (R2.contains(element)) minR2.add(element);
  });

  print(minR2);

  int min2 = 10;
  var minR2Subject;
  minR2.forEach((element) {
    if (min2 >
        int.parse(
            selectedGradeValues[selectedSubjectValues.indexOf(element)][1])) {
      min2 = int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
      minR2Subject = element;
    }
  });

  duplicateSubjects.remove(minR2Subject);
  score += min2;

  //find best 2 left in duplicateSubjects
  print(duplicateSubjects);

  if (duplicateSubjects.length == 2) {
    duplicateSubjects.forEach((element) {
      score += int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
    });
  } else {
    //pick best 2
    List leftOverGrades = [];
    duplicateSubjects.forEach((element) {
      leftOverGrades.add(int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]));
    });

    leftOverGrades.sort();

    print(leftOverGrades);

    int sum;
    sum = leftOverGrades[0] + leftOverGrades[1];
    score += sum;
  }

  print(score);

  return score;
}

int computeELR2B2_B(List selectedSubjectValues, List selectedGradeValues) {
  int score = 0;

  List duplicateSubjects = List.from(selectedSubjectValues);

  score += int.parse(
      selectedGradeValues[duplicateSubjects.indexOf('English Language')]
      [1]); //find english grade and add to score

  duplicateSubjects.removeAt(duplicateSubjects.indexOf('English Language'));

  List R1 = [
    'Additional Mathematics',
    'Elementary Mathematics'
  ];

  List minR1 = [];
  duplicateSubjects.forEach((element) {
    if (R1.contains(element)) minR1.add(element);
  });

  print(minR1);

  int min = 10;
  var minR1Subject;
  minR1.forEach((element) {
    if (min >
        int.parse(
            selectedGradeValues[selectedSubjectValues.indexOf(element)][1])) {
      min = int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
      minR1Subject = element;
    }
  });

  duplicateSubjects.remove(minR1Subject);
  score += min;

  List R2 = [
    'Art/Art & Design',
    'Business Studies',
    'Combined Humanities',
    'Commerce',
    'Commercial Studies',
    'Economics',
    'Geography',
    'Higher Art',
    'Higher Music',
    'History',
    'Humanities (Social Studies, Literature in English)',
    'Humanities (Social Studies, Literature in Chinese)',
    'Humanities (Social Studies, Literature in Malay)',
    'Humanities (Social Studies, Literature in Tamil)',
    'Humanities (Social Studies, History)',
    'Humanities (Social Studies, Geography)',
    'Intro to Enterprise Development',
    'Literature in English',
    'Literature in Chinese',
    'Literature in Malay',
    'Literature in Tamil',
    'Media Studies (English)',
    'Media Studies (Chinese)',
    'Music',
    'Principles of Accounts',
  ];

  List minR2 = [];
  duplicateSubjects.forEach((element) {
    if (R2.contains(element)) minR2.add(element);
  });

  print(minR2);

  int min2 = 10;
  var minR2Subject;
  minR2.forEach((element) {
    if (min2 >
        int.parse(
            selectedGradeValues[selectedSubjectValues.indexOf(element)][1])) {
      min2 = int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
      minR2Subject = element;
    }
  });

  duplicateSubjects.remove(minR2Subject);
  score += min2;

  //find best 2 left in duplicateSubjects
  print(duplicateSubjects);

  if (duplicateSubjects.length == 2) {
    duplicateSubjects.forEach((element) {
      score += int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
    });
  } else {
    //pick best 2
    List leftOverGrades = [];
    duplicateSubjects.forEach((element) {
      leftOverGrades.add(int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]));
    });

    leftOverGrades.sort();

    print(leftOverGrades);

    int sum;
    sum = leftOverGrades[0] + leftOverGrades[1];
    score += sum;
  }

  print(score);

  return score;
}

int computeELR2B2_C(List selectedSubjectValues, List selectedGradeValues) {
  int score = 0;

  List duplicateSubjects = List.from(selectedSubjectValues);

  score += int.parse(
      selectedGradeValues[duplicateSubjects.indexOf('English Language')]
      [1]); //find english grade and add to score

  duplicateSubjects.removeAt(duplicateSubjects.indexOf('English Language'));

  List R1 = [
    'Additional Mathematics',
    'Elementary Mathematics',
  ];

  List minR1 = [];
  duplicateSubjects.forEach((element) {
    if (R1.contains(element)) minR1.add(element);
  });

  print(minR1);

  int min = 10;
  var minR1Subject;
  minR1.forEach((element) {
    if (min >
        int.parse(
            selectedGradeValues[selectedSubjectValues.indexOf(element)][1])) {
      min = int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
      minR1Subject = element;
    }
  });

  duplicateSubjects.remove(minR1Subject);
  score += min;

  List R2 = [
    'Addn Combined Science',
    'Additional Science',
    'Biology',
    'Biotechnology',
    'Chemistry',
    'Combined Science',
    'Computing/Computer Studies',
    'Creative 3D Animation',
    'Design & Technology',
    'Food & Nutrition',
    'Electronics/Fundamentals of Electronics',
    'General Science',
    'Human & Social Biology',
    'Integrated Science',
    'Physics/Engineering Science',
    'Science (Chem, Bio)',
    'Science (Phy, Bio)',
    'Science (Phy,Chem)/Physical Science',
    'Science (Phy, Chem, Bio)',
  ];


  List minR2 = [];
  duplicateSubjects.forEach((element) {
    if (R2.contains(element)) minR2.add(element);
  });

  print(minR2);

  int min2 = 10;
  var minR2Subject;
  minR2.forEach((element) {
    if (min2 >
        int.parse(
            selectedGradeValues[selectedSubjectValues.indexOf(element)][1])) {
      min2 = int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
      minR2Subject = element;
    }
  });

  duplicateSubjects.remove(minR2Subject);
  score += min2;

  //find best 2 left in duplicateSubjects
  print(duplicateSubjects);

  if (duplicateSubjects.length == 2) {
    duplicateSubjects.forEach((element) {
      score += int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
    });
  } else {
    //pick best 2
    List leftOverGrades = [];
    duplicateSubjects.forEach((element) {
      leftOverGrades.add(int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]));
    });

    leftOverGrades.sort();

    print(leftOverGrades);

    int sum;
    sum = leftOverGrades[0] + leftOverGrades[1];
    score += sum;
  }

  print(score);

  return score;
}

int computeELR2B2_D(List selectedSubjectValues, List selectedGradeValues) {
  int score = 0;

  List duplicateSubjects = List.from(selectedSubjectValues);

  score += int.parse(
      selectedGradeValues[duplicateSubjects.indexOf('English Language')]
      [1]); //find english grade and add to score

  duplicateSubjects.removeAt(duplicateSubjects.indexOf('English Language'));

  List R1 = [
    'Additional Mathematics',
    'Elementary Mathematics',
  ];

  List minR1 = [];
  duplicateSubjects.forEach((element) {
    if (R1.contains(element)) minR1.add(element);
  });

  print(minR1);

  int min = 10;
  var minR1Subject;
  minR1.forEach((element) {
    if (min >
        int.parse(
            selectedGradeValues[selectedSubjectValues.indexOf(element)][1])) {
      min = int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
      minR1Subject = element;
    }
  });

  duplicateSubjects.remove(minR1Subject);
  score += min;

  List R2 = [
    'Addn Combined Science',
    'Additional Science',
    'Art/Art & Design',
    'Biology',
    'Biotechnology',
    'Chemistry',
    'Combined Science',
    'Computing/Computer Studies',
    'Creative 3D Animation',
    'Design & Technology',
    'Design Studies',
    'Food & Nutrition',
    'Electronics/Fundamentals of Electronics',
    'General Science',
    'Higher Art',
    'Human & Social Biology',
    'Integrated Science',
    'Media Studies (English)',
    'Media Studies (Chinese)',
    'Physics/Engineering Science',
    'Science (Chem, Bio)',
    'Science (Phy, Bio)',
    'Science (Phy, Chem)/Physical Science',
    'Science (Phy, Chem, Bio)',
  ];


  List minR2 = [];
  duplicateSubjects.forEach((element) {
    if (R2.contains(element)) minR2.add(element);
  });

  print(minR2);

  int min2 = 10;
  var minR2Subject;
  minR2.forEach((element) {
    if (min2 >
        int.parse(
            selectedGradeValues[selectedSubjectValues.indexOf(element)][1])) {
      min2 = int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
      minR2Subject = element;
    }
  });

  duplicateSubjects.remove(minR2Subject);
  score += min2;

  //find best 2 left in duplicateSubjects
  print(duplicateSubjects);

  if (duplicateSubjects.length == 2) {
    duplicateSubjects.forEach((element) {
      score += int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]);
    });
  } else {
    //pick best 2
    List leftOverGrades = [];
    duplicateSubjects.forEach((element) {
      leftOverGrades.add(int.parse(
          selectedGradeValues[selectedSubjectValues.indexOf(element)][1]));
    });

    leftOverGrades.sort();

    print(leftOverGrades);

    int sum;
    sum = leftOverGrades[0] + leftOverGrades[1];
    score += sum;
  }

  print(score);

  return score;
}