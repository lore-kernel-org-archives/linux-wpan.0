Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36593 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbKLAOt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Nov 2015 19:14:49 -0500
Received: by wmww144 with SMTP id w144so180125392wmw.1
        for <linux-wpan@vger.kernel.org>; Wed, 11 Nov 2015 16:14:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6Pi3Z3fPsDX3EBYhfn96ZLgXxQ5TAYAr7Rk3MKHcoZqxA@mail.gmail.com>
References: <CAPpUg6NwiRzUMEPGpZa3=Ppg3LF3N7u1=o_sA0+rp5aHt0CC9g@mail.gmail.com>
	<CAF4BF-TStucwTg5Kp+YAN735RNQUA+aLf1fEPRKW7uSNZXSKYw@mail.gmail.com>
	<CAPpUg6Pi3Z3fPsDX3EBYhfn96ZLgXxQ5TAYAr7Rk3MKHcoZqxA@mail.gmail.com>
Date: Thu, 12 Nov 2015 01:14:48 +0100
Message-ID: <CAPpUg6O65Uyy+rhOdqh-cKK_w-4SqPvi9Ho6AGBFD7xUq4hukw@mail.gmail.com>
Subject: Re: 6lowpan socket
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christopher Friedt <chrisfriedt@gmail.com>
Cc: linux-wpan@vger.kernel.org

 From Christopher:

Oh - sorry. 6LowPAN uses IPv6. So it's equivalent to setting up an IPv6 socket.

Just remember to set up routes as appropriate and it should work fine.

Unfortunately, I think vger bounces email from android devices, so my
message won't make it out on the list.

©

Sent from my Android

Yeah sure, it's equivalent, it's what I thought. I will search deeper

2015-11-11 23:06 GMT+01:00 Baptiste Clenet <bapclenet@gmail.com>:
> Hi Christopher,
> On http://wpan.cakelab.org/, there is no 6lowpan socket example, it
> explains how to set up the network. All my interfaces (wpan0 and
> lowpan0) are already running.
>
> 2015-11-11 22:55 GMT+01:00 Christopher Friedt <chrisfriedt@gmail.com>:
>> http://wpan.cakelab.org/
>>
>> ©
>>
>> Sent from my Android
>
>
>
> --
> Baptiste



-- 
Baptiste
