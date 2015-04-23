Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37904 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965418AbbDWMIj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 08:08:39 -0400
Received: by wiun10 with SMTP id n10so89918275wiu.1
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 05:08:39 -0700 (PDT)
Date: Thu, 23 Apr 2015 14:08:36 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: First kernel patch - checkpatch for at86rf230.c, false-positives?
Message-ID: <20150423120835.GC9284@omega>
References: <CAG9Fz+uvR29TX4-MavSqA=MPkUhsn7n0HnaDzh4PDAmrMvrsVQ@mail.gmail.com>
 <20150423100918.GA9284@omega>
 <CAG9Fz+usxJ-9ME2VoODfO1W2usMophATuYD5Nxer_w9TXj9Rag@mail.gmail.com>
 <20150423111553.GB9284@omega>
 <CAG9Fz+tcYsL_iUp7eLHWMB8B9Qrmi7C4HG6ROffyxQzhJo8BNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG9Fz+tcYsL_iUp7eLHWMB8B9Qrmi7C4HG6ROffyxQzhJo8BNQ@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Apr 23, 2015 at 01:48:05PM +0200, Christoffer Holmstedt wrote:
> Yea, "breaking the ice" is what I need. So something like
> "TRX_STATE_MASK (0x1f)"?

yes or cleanup the style issue "tabs after define" in the SR/RG defines.
It's simple a search & replace in your editor with s/define\t/define /
in that range (that's how I fix it). I will remove it then in my branch.

... or running aspell on that file, I am sure I did several typos there.
That's what others linux developers also do, running some automatic code
checkers (also aspell), but there exist more outside cppcheck, rats,
spare etc. (Normally the maintainer should run this before each patch
and I try to do that).

- Alex
