package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.Address;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AddressRepository extends JpaRepository<Address, Long> {
}
