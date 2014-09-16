Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52356 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbaIPMtB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 08:49:01 -0400
Date: Tue, 16 Sep 2014 14:48:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140916124832.GB5576@omega>
References: <1410865319-16310-2-git-send-email-martin.townsend@xsilon.com>
 <20140916113614.GC4969@omega>
 <5418215F.5050308@xsilon.com>
 <20140916114759.GD4969@omega>
 <20140916115357.GE4969@omega>
 <20140916120247.GA5217@omega>
 <20140916121844.GA5349@omega>
 <54182C6B.6090801@xsilon.com>
 <20140916123421.GA5576@omega>
 <54182FB8.4080103@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54182FB8.4080103@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Martin,

On Tue, Sep 16, 2014 at 01:40:24PM +0100, Martin Townsend wrote:
...
> 
> Yes I see the problem now, maybe it's better to revert back to skb_inout, less chance of introducing bugs and then we have a well defined return value.
> 

No problem, for me it's okay, if this is okay for Jukka, we can change
it later to a better behaviour. Jukka please answer what you think about this.

I also did a small c example because this now:

char *foo(char *buf)
{
        char *new;

        if (some_error)
                return NULL;

        if (some_error)
                return NULL;

        new = expand(buf, 23);
        if (!new)
                return NULL;

        free(buf);
        buf = new;

	/* buf is now different than the parameter buf */
        if (some_error)
                return NULL;
             
        return buf;
}             
              
int main(int argc, const char *argv[])
{             
        char *local_buf = malloc(42);
        char *buf;
             
        buf = foo(local_buf);
        if (!buf) {
                /* BUG */
                /* we don't know if local_buf is still valid. */
                free(local_buf);
        }        
                 
        return 0;
}

I think if you do buf = foo(buf) you can rescue it but this doesn't
look like a clean solution for me.

- Alex
