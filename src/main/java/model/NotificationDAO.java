package model;

import java.util.List;

import com.sun.nio.sctp.Notification;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

@Stateless
public class NotificationDAO {
	@PersistenceContext
	EntityManager em;
	
	public boolean sendNotification(UserEntity receiver,BookingEntity booking,String message) {
		try {
			NotificationEntity noti = new NotificationEntity();
			
			noti.setUser(receiver);
			noti.setBooking(booking);
			noti.setMessage(message);
			
			em.persist(noti);
			return true;
		}
		catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public List<NotificationEntity> getDriverBookingNotifications(UserEntity user){
		try {
			TypedQuery<NotificationEntity> query = em.createQuery(
					"SELECT noti "
					+ "FROM NotificationEntity noti "
						+ "JOIN noti.user u "
						+ "JOIN noti.booking b "
					+ "WHERE u.userId = ?1 "
					+ "AND b.statusBooking IN (?2,?3)"
				, NotificationEntity.class);
			query.setParameter(1, user.getUserId());
			query.setParameter(2, BookingEntity.BookingStatus.UPCOMING);
			query.setParameter(3, BookingEntity.BookingStatus.CANCELLED);
			List<NotificationEntity> notifications = query.getResultList();
			notifications.forEach((NotificationEntity noti) -> {
				noti.getBooking();
				noti.getBooking().getStudent().getUser();
				
			});
			return notifications;
		}
		catch(Exception e) {
			System.out.println(e);
			return null;
		}
	}
}
