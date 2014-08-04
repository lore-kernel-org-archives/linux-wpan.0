Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Message-ID: <53DF4F7B.4090307@xsilon.com>
Date: Mon, 04 Aug 2014 10:16:43 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
References: <53DF4B10.7000209@xsilon.com> <20140804090403.GB15334@omega>
In-Reply-To: <20140804090403.GB15334@omega>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-zigbee-devel>
List-Post: <mailto:linux-zigbee-devel@lists.sourceforge.net>
List-Help: <mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel>,
	<mailto:linux-zigbee-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-zigbee-devel-bounces@lists.sourceforge.net
Subject: Re: [Linux-zigbee-devel] [PATCH v3 bluetooth-next] Simplify lowpan
 receive path so skb is freed in, lowpan_rcv when dropped.
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org, linux-zigbee-devel@lists.sourceforge.net
List-ID: <linux-wpan.vger.kernel.org>

The changes were made to a clone of bluetooth-next, do I have the right repository?

martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git ls-remote
>From git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git

- Martin.

On 04/08/14 10:04, Alexander Aring wrote:
> Hi Martin,
>
> still conflicts here:
>
> M	include/net/6lowpan.h
> M	net/6lowpan/iphc.c
> M	net/bluetooth/6lowpan.c
> M	net/ieee802154/6lowpan_rtnl.c
> <stdin>:91: trailing whitespace.
> 		
> warning: 1 line adds whitespace errors.
> Falling back to patching base and 3-way merge...
> Auto-merging net/ieee802154/6lowpan_rtnl.c
> Auto-merging net/bluetooth/6lowpan.c
> Auto-merging net/6lowpan/iphc.c
> CONFLICT (content): Merge conflict in net/6lowpan/iphc.c
> Auto-merging include/net/6lowpan.h
> Failed to merge in the changes.
> Patch failed at 0001 Simplify lowpan receive path so skb is freed in, lowpan_rcv when dropped.
>
>
> Save your work in a branch.
>
> Do you have bluetooth-next in your remotes? Then run "git remote update
> $REMOTE_NAME" and checkout $REMOTE_NAME/master, then use git cherry-pick
> to add patches from the branch.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Linux-zigbee-devel mailing list
Linux-zigbee-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-zigbee-devel
