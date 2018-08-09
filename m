Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:45375 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727601AbeHILI2 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 9 Aug 2018 07:08:28 -0400
Subject: Re: [PATCH net-next] ieee802154: Use kmemdup instead of duplicating
 it in ca8210_test_int_driver_write
References: <20180809064429.13348-1-yuehaibing@huawei.com>
 <488f54b7-cfe2-f64b-168e-11f79d4d4e96@datenfreihafen.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <aaf879dd-c630-a201-b8ae-66c39a359a99@huawei.com>
Date: Thu, 9 Aug 2018 16:44:32 +0800
MIME-Version: 1.0
In-Reply-To: <488f54b7-cfe2-f64b-168e-11f79d4d4e96@datenfreihafen.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>, davem@davemloft.net, h.morris@cascoda.com, alex.aring@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

On 2018/8/9 16:13, Stefan Schmidt wrote:
> Hello.
> 
> On 08/09/2018 08:44 AM, YueHaibing wrote:
>> Replace calls to kmalloc followed by a memcpy with a direct call to
>> kmemdup.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Is Yue your forname and Haibing your surname? In that case having it
> written as
> 
> Yue Haibing <yuehaibing@huawei.com>

Well, It should be this, but it's been a long time to use the former

> 
> in the from line as well as in the SOB would be better.
> 
>> ---
>>  drivers/net/ieee802154/ca8210.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
>> index 58299fb..e21279d 100644
>> --- a/drivers/net/ieee802154/ca8210.c
>> +++ b/drivers/net/ieee802154/ca8210.c
>> @@ -634,10 +634,9 @@ static int ca8210_test_int_driver_write(
>>  	for (i = 0; i < len; i++)
>>  		dev_dbg(&priv->spi->dev, "%#03x\n", buf[i]);
>>  
>> -	fifo_buffer = kmalloc(len, GFP_KERNEL);
>> +	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
>>  	if (!fifo_buffer)
>>  		return -ENOMEM;
>> -	memcpy(fifo_buffer, buf, len);
>>  	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
>>  	wake_up_interruptible(&priv->test.readq);
> 
> Is this some kernel tree wide change you are submitting patches for or
> only for the ca8210 driver? Is there any specific problem you see with
> the kmalloc and memcpy code here? To me it looks fine.
> 
> The reason I ask is to understand if this is bug fix or a cleanup.

It just a code cleanup only for ca8210.

> 
> Harry, if you are ok with this one let me know with an Acked-By
> 
> regards
> Stefan Schmidt
> 
> .
> 

