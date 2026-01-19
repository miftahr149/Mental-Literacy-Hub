package my.utm.mentalhealthapp.entity;

import javax.persistence.*;

@Entity
@Table(name = "challenge_activities")
public class ResourceUsage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
}