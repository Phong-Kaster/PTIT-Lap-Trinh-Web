/**************************************************
 * @author Phong
 * 
 * Step 1: hien thong bao xoa
 * Step 2: neu chon CÓ 
 * Step 2.1: goi ajax de xoa doi tuong
 * Step 2.2: hien thong bao hoan tat
 * @return gui ajax xoa the loai nay di
 **************************************************/



let removeInformationPage = ()=>{
    $(".btn-remove-information-page").unbind("click").on("click", function(){

        let id = $(this).data("uid");

        /*Step 1*/
        Swal.fire({
            title: 'Bạn có chắc chắn xóa không ?',
            text: "Bạn sẽ không thể khôi phục hành động này!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có',
            cancelButtonText: 'Không'
          }).then((result) => {
	
            /*Step 2*/
            if (result.isConfirmed) {
			
			  ajaxRemoveInformationPage(id);
				
            }
          })
    });
}




/**************************************************
 * @author Phong
 * Neu thanh cong thi in thong bao Swal.fire
 * Neu that bai thi in thong bao swalWithBootstrapButtons.fire
 * 
 * Chu y: Nho de y them duoi .htm vao cuoi duong dan, tui thieu cai nay ma do mai khong ra 
 * minh sai o dau. Mai moi phat hien ta la thieu .htm ༎ຶ‿༎ຶ
 * @return gui id cua the loai muon xoa len server
 **************************************************/
let ajaxRemoveInformationPage = (id)=>{
	
    $.ajax({
		url:`${URL}/admin/remove-information-page.htm`,
		type:"GET",
		data: {
			id: id
		},
		success: function(data)
		{
			/*IN THONG BAO NEU THANH CONG*/
			if(data == "success")
			{
				Swal.fire(
                'Hoàn tất!',
                'Thao tác thành công',
                'success'
              );
		
		
			  /* XOA PHAN TU HIEN TAI TREN VIEW */
			  $(".table tbody").find(`tr[data-uid = ${id}]`).remove();
			}
			/*IN THONG BAO NEU THAT BAI */
			else
			{
				Swal.fire(
			      'Thất bại !',
			      'Thao tác xảy ra sự cố',
			      'error'
			    );
			}
			
		},
		error : function(e) 
		{
			console.log("ERROR: ", e);
		}
		
	});
}


/**************************************************
 * @author Phong
 * Step 1: lay ra ModelAttribute bang serialize() 
 * Step 2: lay du lieu phan hoi va dieu huong tuy theo du lieu nhan duoc 
 *   	Neu thanh cong thi chuyen huong ve admin/category.htm
 *		Neu that bai thi dung yen
 * @return chinh sua the loai chon CO se gui du lieu toi server hoan tat luu lai
 **************************************************/
let confirmEditInformationPage = ()=>{
	$("#btn-edit-information-page-confirm").unbind("click").on("click", function(){
		
		/*Step 1 */
		let category = $("#page").serialize();
		let id = $(this).data("uid");
		
		/*Step 2 */
		$.post(`${URL}/admin/edit-information-page-${id}.htm`, category  , function(data)
		{
			if( data == "success")
			{
				  Swal.fire('Hoàn tất!','Thao tác thành công','success').then( (result)=>{
			            if (result.isConfirmed) 
						{
						  /* Nhan OK -> Dieu huong ve admin/category.htm */
				  		  window.location.href = `${URL}/admin/information-page.htm`;
			            }
				  });
			}
			else
			{
				Swal.fire('Thất bại !','Thiếu những trường quan trọng','error');
				return;
			}
		})
		
	});
}


/**************************************************
 * @author Phong
 * @return huy bo viec chinh sua hoac them trong informationPageAdd va informationPageEdit
 **************************************************/
let cancelEditInformationPage = ()=>{
	$("#btn-edit-information-page-cancel").unbind("click").on("click", function(){
		
		/*Step 1 */
		Swal.fire({
            title: 'Bạn có chắc chắn huỷ không ?',
            text: "Bạn sẽ không thể khôi phục hành động này!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Có',
            cancelButtonText: 'Không'
          }).then((result) => {
	
            /*Step 2*/
            if (result.isConfirmed) {
			
			   /* Nhan OK -> Dieu huong ve admin/category.htm */
			   window.location.href = `${URL}/admin/information-page.htm`;
				
            }
          })
	});
}



$(document).ready(function(){
    removeInformationPage();

	confirmEditInformationPage();
	
	cancelEditInformationPage();
});