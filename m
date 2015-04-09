Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59126 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbbDIH1D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 03:27:03 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next] mac802154: fix typo for device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150409072147.GA1261@omega>
Date: Thu, 9 Apr 2015 00:26:57 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <2DC78316-950F-45CB-8B83-1D1F7E79909E@holtmann.org>
References: <1428561343-32752-1-git-send-email-varkabhadram@gmail.com> <20150409072147.GA1261@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: varkabhadram@gmail.com, linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Alex,

>> Signed-off-by: Varka Bhadram <varkab@cdac.in>
>> ---
>> include/net/mac802154.h |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
>> index d6a809e..56ef97a 100644
>> --- a/include/net/mac802154.h
>> +++ b/include/net/mac802154.h
>> @@ -247,7 +247,7 @@ static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
>> 	__put_unaligned_memmove64(swab64p(le64_src), be64_dst);
>> }
>> 
>> -/* Basic interface to register ieee802154 hwice */
>> +/* Basic interface to register ieee802154 device */
> 
> This typo occured when I did a 's/dev/hw/' in my editor. This replaced
> all dev to hw.
> 
> I did this because the variable was always named "dev" which was very
> confusing to handle between netdev "dev" and this one. Look at commit:
> 
> 5a50439775853a8d565115edb63a5ab4bb780479 ("ieee802154: rename
> ieee802154_dev to ieee802154_hw")
> 
> For keeping the wireless naming conventation.
> 
> This also means that calling this "device" is wrong and "hw" is correct.
> So we should change the comment to:
> 
> /* Basic interface to register ieee802154 hw */
> 
> or
> 
> /* Basic interface to register ieee802154 hardware */

so I took this patch already since it was obviously making it better than it was before. Once you decide on how you want to handle the comments, please just send cleanup patches that fix all locations.

Regards

Marcel

