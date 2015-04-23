Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36059 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965053AbbDWLsG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 07:48:06 -0400
Received: by wizk4 with SMTP id k4so212687810wiz.1
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 04:48:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150423111553.GB9284@omega>
References: <CAG9Fz+uvR29TX4-MavSqA=MPkUhsn7n0HnaDzh4PDAmrMvrsVQ@mail.gmail.com>
	<20150423100918.GA9284@omega>
	<CAG9Fz+usxJ-9ME2VoODfO1W2usMophATuYD5Nxer_w9TXj9Rag@mail.gmail.com>
	<20150423111553.GB9284@omega>
Date: Thu, 23 Apr 2015 13:48:05 +0200
Message-ID: <CAG9Fz+tcYsL_iUp7eLHWMB8B9Qrmi7C4HG6ROffyxQzhJo8BNQ@mail.gmail.com>
Subject: Re: First kernel patch - checkpatch for at86rf230.c, false-positives?
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Yea, "breaking the ice" is what I need. So something like
"TRX_STATE_MASK (0x1f)"?
--
Christoffer Holmstedt


2015-04-23 13:15 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Thu, Apr 23, 2015 at 12:25:34PM +0200, Christoffer Holmstedt wrote:
> ...
>>
>> Thank you Alexander for your fast and thorough response, I expected
>> something like that as other defines did have parantheses.
>>
>
> if you like to send a first patch, maybe to "breaking the ice". Then I
> see several cleanups there, like I used some magic values for masking
> the trac status or trx state e.g. "trx_state = buf[1] & 0x1f;". You can
> introduce some macro for that and replacing it where it used.
>
> Or simple sending some patches for whatever you want, I/community will review
> them.
>
> With "breaking the ice", I mean some "testing linux send patch
> environment" and getting familiar with sending patches. When it is your
> first time.
>
> - Alex
