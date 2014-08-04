Return-Path: <linux-zigbee-devel-bounces@lists.sourceforge.net>
Date: Mon, 4 Aug 2014 11:36:32 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140804093630.GD15334@omega>
References: <53DF4B10.7000209@xsilon.com> <20140804090403.GB15334@omega>
	<53DF4F7B.4090307@xsilon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53DF4F7B.4090307@xsilon.com>
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
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org, linux-zigbee-devel@lists.sourceforge.net
List-ID: <linux-wpan.vger.kernel.org>

On Mon, Aug 04, 2014 at 10:16:43AM +0100, Martin Townsend wrote:
> The changes were made to a clone of bluetooth-next, do I have the right repository?
> 
> martin@martin-HP-ProDesk-490-G1-MT:~/workspace/bluetooth-next$ git ls-remote
> From git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
> 
yes, but maybe it's a little bit outdated. Try to update it, on top of
git log should be the patches:

http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/log/

- Alex

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
