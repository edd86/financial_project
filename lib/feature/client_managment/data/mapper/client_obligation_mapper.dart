import 'package:financial_project/feature/client_managment/data/model/client_obligation_model.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_obligation.dart';

class ClientObligationMapper {
  static ClientObligation toEntity(ClientObligationModel model) {
    return ClientObligation(
      id: model.id,
      clientId: model.clientId,
      monthlyRecordId: model.monthlyRecordId,
      obligationType: model.obligationType.value,
      simplifiedId: model.simplifiedId,
      generalId: model.generalId,
      paymentAmount: model.paymentAmount,
      appliedPercentage: model.appliedPercentage,
      taxableBase: model.taxableBase,
      dueDate: model.dueDate,
      status: model.status.value,
      periodStart: model.periodStart,
      periodEnd: model.periodEnd,
      calculationNotes: model.calculationNotes,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static ClientObligationModel toModel(ClientObligation entity) {
    return ClientObligationModel(
      id: entity.id,
      clientId: entity.clientId,
      monthlyRecordId: entity.monthlyRecordId,
      obligationType: ObligationType.values.firstWhere(
        (e) => e.name == entity.obligationType,
      ),
      simplifiedId: entity.simplifiedId,
      generalId: entity.generalId,
      paymentAmount: entity.paymentAmount,
      appliedPercentage: entity.appliedPercentage,
      taxableBase: entity.taxableBase,
      dueDate: entity.dueDate,
      status: ObligationStatus.values.firstWhere(
        (e) => e.name == entity.status,
      ),
      periodStart: entity.periodStart,
      periodEnd: entity.periodEnd,
      calculationNotes: entity.calculationNotes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
