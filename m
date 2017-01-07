Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35159 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdAGOVz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 7 Jan 2017 09:21:55 -0500
Received: by mail-qt0-f174.google.com with SMTP id x49so36382959qtc.2
        for <linux-wpan@vger.kernel.org>; Sat, 07 Jan 2017 06:21:55 -0800 (PST)
MIME-Version: 1.0
From: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Date: Sat, 7 Jan 2017 19:51:54 +0530
Message-ID: <CAAK7Ti9=i2wRTmrViZiXuuC=sXsWUmFbjV5pSp0sFVrrGXBpqA@mail.gmail.com>
Subject: Re: Requesting for process, to port driver from contiki to linux
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Thankq Stefan for your advice.




With regards
Janardhanachari


On Jan 6, 2017 7:41 PM, "Stefan Schmidt" <stefan@osg.samsung.com> wrote:

> Hello.
>
> On 06/01/17 13:57, JANARDHANACHARI KELLA wrote:
>
>> thankq Stefan.
>>
>> can you suggest me, any documents to develop/ write STM Spirit1
>> supported module?
>>
>
> If you want to get any help or support here you should read what people
> are writing you. Alexander told you at least two times now to keep the
> mailing list in cc when replying and STOP top posting on this list. (If you
> do not know what he means I suggest you look it up). I you keep ignoring
> this people will just ignore you.
>
> And if you no read again what I wrote you will see that I already
> suggested you to look at the existing drivers. We are a group of volunteers
> here working on Linux-wpan. If nobody has an interest to spent his time on
> writing a guide how to develop a driver for for transceiver XXX it just
> does not happen.
>
> You best bet it to take a look at the existing drivers, learn how they are
> hooked up to the stack and interact with the kernel. Take the datasheet (if
> the vendor offers one to you) and match what logic you find there to drive
> the hardware to what we have.
>
> regards
> Stefan Schmidt
