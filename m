Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55531 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeLKI1G (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Dec 2018 03:27:06 -0500
Subject: Re: [PATCH net-next] ieee802154: ca8210: fix possible u8 overflow in
 ca8210_rx_done
References: <20181211031339.21048-1-yuehaibing@huawei.com>
 <20181210.220107.751606140724107779.davem@davemloft.net>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <87dbac94-8b2e-8cef-5166-8c130529ceb9@datenfreihafen.org>
Date: Tue, 11 Dec 2018 09:26:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181210.220107.751606140724107779.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Miller <davem@davemloft.net>, yuehaibing@huawei.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

Hello Dave.

On 11.12.18 07:01, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Tue, 11 Dec 2018 11:13:39 +0800
> 
>> gcc warning this:
>>
>> drivers/net/ieee802154/ca8210.c:730:10: warning:
>>  comparison is always false due to limited range of data type [-Wtype-limits]
>>
>> 'len' is u8 type, we get it from buf[1] adding 2, which can overflow.
>> This patch change the type of 'len' to unsigned int to avoid this,also fix
>> the gcc warning.
>>
>> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> WPAN maintainers, I am assuming that as maintainers you will be
> picking this up and sending it to me.

That's correct. On driver patches I always wait 2 days or so to give the
driver maintainer a chance to reply before I go ahead and apply it.

I will take this one directly now and do some smoke testing. It will
come together with another fix as pull request to you.

regards
Stefan Schmidt
