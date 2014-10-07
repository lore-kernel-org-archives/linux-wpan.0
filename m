Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:60761 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaJGHmq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 03:42:46 -0400
Received: by mail-wg0-f47.google.com with SMTP id x13so8419843wgg.6
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 00:42:45 -0700 (PDT)
Date: Tue, 7 Oct 2014 09:42:42 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next] 6lowpan: cleanup for lowpan_rcv
Message-ID: <20141007074240.GB2768@omega>
References: <1412654055-15368-1-git-send-email-varkabhadram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412654055-15368-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: varkabhadram@gmail.com
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Varka,

On Tue, Oct 07, 2014 at 09:24:15AM +0530, varkabhadram@gmail.com wrote:
> From: Varka Bhadram <varkab@cdac.in>
> 
> Instead of collecting the return value into 'ret' variable and
> checking the perticular return value specifically, this patch
> remove these by directly including function within 'if' statement
> 

My opinion to this patch hasn't changed. The return value handling of
these functions are current broken and Martin works on this. After Martin
get his patches in you can do some cleanup here.

- Alex
