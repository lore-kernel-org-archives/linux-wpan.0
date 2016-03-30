Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36135 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbcC3Ut4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Mar 2016 16:49:56 -0400
Received: by mail-ig0-f179.google.com with SMTP id nk17so112074085igb.1
        for <linux-wpan@vger.kernel.org>; Wed, 30 Mar 2016 13:49:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56FC3A38.7030305@osg.samsung.com>
References: <CALqexQVqxwfKxZ=fmtjQPnHcdibVFmFTG4dRZkBwC4aJfLkE5A@mail.gmail.com>
	<20160329083732.GA1114@omega>
	<CALqexQUhA-wTJow59_PkkbnmJz8UWxW2WoCdU=qYHYNQjyMVvQ@mail.gmail.com>
	<56FB8E7F.70106@osg.samsung.com>
	<CALqexQWw4QuPWxTDe8SdHxeOptq6TCf-O4Mq_UL-pDxqUz=h1A@mail.gmail.com>
	<56FC3A38.7030305@osg.samsung.com>
Date: Thu, 31 Mar 2016 03:49:55 +0700
Message-ID: <CALqexQV2z5wR3y8pUtWeF0eENyo3v6pdak6sm09g7LcPuQ+4cA@mail.gmail.com>
Subject: Re: No device found for binding socket ieee802.15.4
From: Adika Bintang Sulaeman <adikabintang78@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

> I still don't see why you would need to do this. What did you change?

Sorry, I think I didn't explain clearly. I forgot to set pan_id and
short address. Now the wpan-ping works fine. I tried to create a
server program which is based on 802.15.4 and 6LoWPAN, and I imitate
the code from wpan-ping. I didn't mean that I literally changed the
wpan-ping.

> Its the normal IPv6 socket API of linux.

Thank you for your explanation, Stefan Schmidt.

Regards
