Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:50110 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbaJ2Kjh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 06:39:37 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so2724428pdj.15
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 03:39:37 -0700 (PDT)
Message-ID: <5450C332.8020200@gmail.com>
Date: Wed, 29 Oct 2014 16:06:34 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next v2] MAINTAINERS: add cc2520 driver maintainer
References: <1414571553-9567-1-git-send-email-varkab@cdac.in> <20141029090410.GA30457@omega>
In-Reply-To: <20141029090410.GA30457@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On 10/29/2014 02:34 PM, Alexander Aring wrote:
> On Wed, Oct 29, 2014 at 02:02:33PM +0530, Varka Bhadram wrote:
>> This patch adds maintainer for cc2520 radio driver.
>>
>> Signed-off-by: Varka Bhadram <varkab@cdac.in>
>> ---
>>   MAINTAINERS |    8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 15867a6..43dc166 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4698,6 +4698,14 @@ F:	include/net/cfg802154.h
>>   F:	include/net/ieee802154_netdev.h
>>   F:	Documentation/networking/ieee802154.txt
>>   
>> +CC2520 IEEE-802.15.4 RADIO DRIVER
>> +M:	Varka Bhadram <varkabhadram@gmail.com>
>> +L:	linux-wpan@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/net/ieee802154/cc2520.c
>> +F:	include/linux/spi/cc2520.h
>> +F:	Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
>> +
> The sequence in this file need to be in lexicographical order. Please
> fix that.

Ok I will fix it.

> - Alex


-- 
Regards,
Varka Bhadram.

