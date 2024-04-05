import '../../features/authentication/data/fake_app_user.dart';
import '../../utils/gen_fake_uuid.dart';

final kFakeUsers = <FakeAppUser>[
  FakeAppUser(
    uid: genFakeUuid('test1@email.com'),
    email: 'test1@email.com',
    name: 'Kehinde',
    surname: 'User 1',
    password: 'Password1!',
  ).copyWith(uid: genFakeUuid('test1@email.com')),
  FakeAppUser(
    uid: genFakeUuid('test2@email.com'),
    email: 'test2@email.com',
    name: 'Salvo',
    surname: 'User 2',
    password: 'Password2!',
  ),
  FakeAppUser(
    uid: genFakeUuid('test3@email.com'),
    email: 'test3@email.com',
    name: 'Maria',
    surname: 'User 3',
    password: 'Password3!',
  ),
  FakeAppUser(
    uid: genFakeUuid('test4@email.com'),
    email: 'test4@email.com',
    name: 'Rocco',
    surname: 'User 4',
    password: 'Password4!',
  ),
  FakeAppUser(
    uid: genFakeUuid('test5@email.com'),
    email: 'test5@email.com',
    name: 'Angelo',
    surname: 'User 5',
    password: 'Password5!',
  ),
  FakeAppUser(
    uid: genFakeUuid('test6@email.com'),
    email: 'test6@email.com',
    name: 'Giuseppe',
    surname: 'User 6',
    password: 'Password6!',
  ),
  FakeAppUser(
    uid: genFakeUuid('test7@email.com'),
    email: 'test7@email.com',
    name: 'Giovanni',
    surname: 'User 7',
    password: 'Password7!',
  ),
  FakeAppUser(
    uid: genFakeUuid('test8@email.com'),
    email: 'test8@email.com',
    name: 'Eugenio',
    surname: 'User 8',
    password: 'Password8!',
  ),
  FakeAppUser(
    uid: genFakeUuid('test9@email.com'),
    email: 'test9@email.com',
    name: 'Utente senza nome',
    surname: 'User 9',
    password: 'Password9!',
  ),
  FakeAppUser(
    uid: genFakeUuid('test10@email.com'),
    email: 'test10@email.com',
    name: 'Utente senza nome 2',
    surname: 'User 10',
    password: 'Password10!',
  ),
];