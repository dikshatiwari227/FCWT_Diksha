%module rename_scope

%inline 
%{ 
  namespace oss 
  { 
    enum Polarization { UnaryPolarization, BinaryPolarization }; 
 
    template <Polarization P> 
    struct Interface_
    { 
    };    
  } 
%} 
 
namespace oss 
{ 
  // Interface_ 
  %template(Interface_UP) Interface_<UnaryPolarization>; 
  %template(Interface_BP) Interface_<BinaryPolarization>; 
 
} 
%inline 
%{ 
  namespace oss 
  { 
    namespace interfaces 
    { 
      template <Polarization P> 
      struct Natural : Interface_<P> 
      { 
           int test(void) { return 1; }
      };      
    } 
  } 
%} 
 
namespace oss 
{ 
  namespace interfaces 
  {    
    %rename(rtest) Natural<UnaryPolarization>::test;
    %rename(rtest) Natural<oss::BinaryPolarization>::test;
    
    // Natural 
    %template(Natural_UP) Natural<UnaryPolarization>; 
    %template(Natural_BP) Natural<BinaryPolarization>; 
  } 
} 

// Note not: Utilities::Bucket::operator==
%rename("equals") Utilities::operator==;

%ignore Utilities::operator<<;
namespace Utilities {
  %ignore operator>>;
}

%inline %{
#include <iostream>

  namespace Utilities {
    class Bucket
    {
    public:
      Bucket() : m_left(0) {}
      friend bool operator==(const Bucket& lhs, const Bucket& rhs){
	return ( rhs.m_left == lhs.m_left );
      }
      friend std::ostream& operator<<(std::ostream&, const Bucket &);
      friend std::ostream& operator>>(std::ostream&, const Bucket &);
    private:
      int m_left;
    };
  }
  
%}
