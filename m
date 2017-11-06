Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:34550 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752989AbdKFPXk (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 6 Nov 2017 10:23:40 -0500
Subject: Re: [PATCH 12/14] ieee802154: cc2520: use __func__ macro for debug
 messages
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-13-stefan@osg.samsung.com>
 <CAEUmHyZ1oaMjqzMHgNtMg+S2cmq2DvvgAkxBsP6-dkzYp0KyOw@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <203cffe0-c39e-dca7-bc78-8bcaffa1d1cf@osg.samsung.com>
Date: Mon, 6 Nov 2017 16:23:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAEUmHyZ1oaMjqzMHgNtMg+S2cmq2DvvgAkxBsP6-dkzYp0KyOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, Alan Ott <alan@signal11.us>

Hello Varka.

On 11/06/2017 04:04 PM, Varka Bhadram wrote:
> On Fri, Sep 22, 2017 at 5:44 PM, Stefan Schmidt <stefan@osg.samsung.com <mailto:stefan@osg.samsung.com>> wrote:
> 
>     Instead of having the function name hard-coded (it might change and we
>     forgot to update them in the debug output) we can use __func__ instead
>     and also shorter the line so we do not need to break it.
>     Found by checkpatch.
> 
>     Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>     ---
> 
>  Acked-by: varkabhadram@gmail.com 

Your acked-by line is missing your real name. I will fix it up for the three acks you just sent. Please keep it in mind for the next time
though :)

regards
Stefan Schmidt
