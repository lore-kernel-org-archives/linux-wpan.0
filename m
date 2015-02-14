Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:33913 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbbBNWJD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Feb 2015 17:09:03 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCHv5 bluetooth-next 0/3] 6lowpan: introduce nhc framework
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150214215724.GA18210@omega>
Date: Sat, 14 Feb 2015 14:08:56 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <D715501C-7BF3-4749-85F5-412A415AE0D5@holtmann.org>
References: <1420818179-18585-1-git-send-email-alex.aring@gmail.com> <777F808E-9C18-4C35-8C1C-4FD732F4FDC1@holtmann.org> <20150214215724.GA18210@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Hi Alex,

>> so I collected the reviewed-by and acked-by statements, but when I did a simple compile test it failed badly.
>> 
>>  CC      net/6lowpan/nhc.o
>> net/6lowpan/nhc.c: In function ‘lowpan_nhc_add’:
>> net/6lowpan/nhc.c:206:2: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘size_t’ [-Wformat=]
>>  WARN_ONCE(nhc->idlen > LOWPAN_NHC_MAX_ID_LEN,
>>  ^
>> 
> 
> mhh, okay. Should be fixed with a conversion from "%d" -> "%zd". I will
> resend a new series with this fix. Thanks.

I can do that change inline if that is the only change needed.

Regards

Marcel

