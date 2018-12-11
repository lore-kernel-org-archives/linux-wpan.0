Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:49788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727633AbeLKBvh (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 10 Dec 2018 20:51:37 -0500
Subject: Re: [PATCH net-next] ieee802154: ca8210: remove a dead branch
References: <20181210113443.22796-1-yuehaibing@huawei.com>
 <20181210.120402.2087888281534527051.davem@davemloft.net>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <906cefad-8f4d-9f50-4011-4b6de78ca592@huawei.com>
Date: Tue, 11 Dec 2018 09:51:31 +0800
MIME-Version: 1.0
In-Reply-To: <20181210.120402.2087888281534527051.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: h.morris@cascoda.com, alex.aring@gmail.com, stefan@datenfreihafen.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

On 2018/12/11 4:04, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Mon, 10 Dec 2018 19:34:43 +0800
> 
>> Fix follwing gcc warning:
>>
>> drivers/net/ieee802154/ca8210.c:730:10: warning:
>>  comparison is always false due to limited range of data type [-Wtype-limits]
>>
>> the variable 'len' is of type u8 and cannot greater than
>> CA8210_SPI_BUF_SIZE , which is 256.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Then bug is the variable type here.
> 
> We are reading a u8 from buf[], then adding 2, which can overflow.
> 
> 'len' should be an unsigned int or similar.

Oh, Yes, will do it in v2.

> 
> .
> 
